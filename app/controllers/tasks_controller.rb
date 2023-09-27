class TasksController < ApplicationController
  load_and_authorize_resource

  def index
    @tasks = Task.all
  end

  def edit
    @task = Task.find(params[:id])
    milestone = Milestone.find(@task.milestone_id)
    @project_members = ProjectUser.includes(:user).where(project_id: milestone.project_id)
    @task_users = TaskUser.where(task_id: @task.id)
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      ActiveRecord::Base.transaction do
        params[:user_ids]&.each do |user_id|
          @task.task_users.create(user_id:)
        end
      end

      @task.update(status: 'In_progress') if params[:user_ids]

      @incomplete_tasks = Task.includes(task_users: [:user])
        .where(milestone_id: @task.milestone_id)
        .where.not(status: 'Completed')
    end

    respond_to(&:turbo_stream)
  end

  def update
    @task = Task.find(params[:id])
    @task.update(task_params)

    @milestone = Milestone.includes(:tasks, :project).find(@task.milestone_id)
    @new_task = Task.new(milestone: @milestone)
    @all_tasks = filtered_tasks(@milestone)
    @project_users = ProjectUser.includes(:user).where(project_id: @milestone.project_id)

    handle_task_users(@task) if task_params[:status] != 'Completed'

    respond_to do |format|
      if @task.errors.empty? && @task.status != 'Completed'
        format.html
      else
        format.turbo_stream
      end
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    all_tasks = Task.where(milestone_id: @task.milestone_id)
    @completed_tasks = all_tasks.select { |task| task.status == 'Completed' }
    @incomplete_tasks = all_tasks - @completed_tasks

    respond_to(&:turbo_stream)
  end

  private

  def task_params
    request_params = params.require(:task).permit(:description, :milestone_id, :priority, :status)
    request_params[:completed_at] = Time.now if params[:task][:status] == 'Completed'

    request_params
  end

  def handle_task_users(task)
    # Get the current user_ids associated with the task
    current_user_ids = task.task_users.pluck(:user_id).map(&:to_i)

    # Determine which user_ids need to be removed and which need to be added
    new_users = params[:user_ids] || []
    users_to_remove = current_user_ids - new_users.map(&:to_i)
    users_to_add = new_users.map(&:to_i) - current_user_ids

    # Remove task_users that need to be removed
    task.task_users.where(user_id: users_to_remove).destroy_all

    users_to_add.each do |user_id|
      task.task_users.create(user_id:)
    end

    if task.task_users.count.positive?
      task.update(status: 'In_progress')
    else
      task.update(status: 'Unassigned')
    end
  end

  def filtered_tasks(milestone)
    incomplete_tasks = milestone.tasks.reject { |task| task.status == 'Completed' }
    completed_tasks = milestone.tasks - incomplete_tasks

    { incomplete_tasks:, completed_tasks: }
  end
end
