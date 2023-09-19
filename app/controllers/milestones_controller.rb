class MilestonesController < ApplicationController
  def index
    @milestones = Project.includes(:milestones).find(params[:project_id])
  end

  def edit
    @milestone = Milestone.find(params[:id])
  end

  def show
    @milestone = Milestone.includes(:tasks, :project).find(params[:id])
    @task = Task.new

    if !@milestone.nil?
      render turbo_stream: turbo_stream.replace(
        "milestone_detail_wrapper",
        partial: 'partials/projects/milestone_detail',
        locals: { milestone: @milestone, task: @task }
      )  
    else
      render turbo_stream: turbo_stream.replace(
        "flash_container",
        partial: 'partials/shared/flash',
        locals: { errors: milestone.errors.full_messages, success: nil }
      )
    end
  end
  
  def create
    @milestone = Milestone.create(milestone_params.merge(project_id: params[:project_id]))
    @project = Project.includes(:milestones).find(params[:project_id])
    
    respond_to do |format|
      format.turbo_stream 
    end
  end
  
  def update
    @milestone = Milestone.find(params[:id])
    @milestone.update(milestone_params)
    @project = Project.includes(:milestones).find(params[:project_id])
    @task = Task.new

    respond_to do |format|
      format.turbo_stream
    end
  end
    
  def destroy
    @milestone = Milestone.find(params[:id])
    @milestone.destroy
    @project = Project.includes(:milestones).find(@milestone.project_id)
    
    respond_to do |format|
      format.turbo_stream 
    end
  end 
    
  private

  def milestone_params
    params.require(:milestone).permit(:title, :due_date, :status)
  end
end
