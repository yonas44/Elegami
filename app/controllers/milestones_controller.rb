class MilestonesController < ApplicationController
  load_and_authorize_resource

  def index
    @milestones = Project.includes(:milestones).find(params[:project_id])
  end

  def edit
    @milestone = Milestone.find(params[:id])
  end

  def show
    @milestone = Milestone.includes(:tasks, :project).find(params[:id])
    @new_task = Task.new(milestone: @milestone)
    @task_user = TaskUser.new
    project_users = ProjectUser.includes(:user).where(project_id: @milestone.project_id)
    all_tasks = filtered_tasks(@milestone)

    if @milestone.nil?
      render turbo_stream: turbo_stream.replace(
        'flash_container',
        partial: 'partials/shared/flash',
        locals: { errors: milestone.errors.full_messages, success: nil }
      )
    else
      render turbo_stream: turbo_stream.replace(
        'milestone_detail_wrapper',
        partial: 'partials/projects/milestone_detail',
        locals: { milestone: @milestone, new_task: @new_task, incomplete_tasks: all_tasks[:incomplete_tasks],
                  completed_tasks: all_tasks[:completed_tasks], project_users: }
      )
    end
  end

  def create
    @milestone = Milestone.create(milestone_params.merge(project_id: params[:project_id]))
    @project = Project.includes(:milestones).find(params[:project_id])

    respond_to(&:turbo_stream)
  end

  def update
    @milestone = Milestone.includes(:tasks).find(params[:id])
    @milestone.update(milestone_params)
    @project = Project.includes(:milestones).find(params[:project_id])
    @new_task = Task.new
    @project_users = ProjectUser.includes(:user).where(project_id: @milestone.project_id)
    @all_tasks = filtered_tasks(@milestone)

    respond_to(&:turbo_stream)
  end

  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    @project = Project.includes(:milestones).find(@milestone.project_id)

    respond_to(&:turbo_stream)
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :project_id, :start_date, :due_date, :status)
  end

  def filtered_tasks(milestone)
    incomplete_tasks = milestone.tasks.reject { |task| task.status == 'Completed' }
    completed_tasks = milestone.tasks - incomplete_tasks

    { incomplete_tasks:, completed_tasks: }
  end
end
