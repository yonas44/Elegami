class MilestonesController < ApplicationController
  def index
    @milestones = Project.includes(:milestones).find(params[:project_id])
  end

  def create
    milestone = Project.find(params[:project_id]).milestones.create(milestone_params)

    respond_to do |format|
      if milestone.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "milestone_container",
            partial: 'partials/projects/single_milestone',
            locals: { milestone: milestone }
          )  
          render turbo_stream: turbo_stream.append(
            "flash_container",
            partial: 'partials/projects/project_flash',
            locals: { success: "Milestone created successfully!", errors: nil}
          )
        end
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "flash_container",
            partial: 'partials/projects/project_flash',
            locals: { errors: milestone.errors.full_messages, success: nil }
          )
        end
      end
    end
  end

  private

  def milestone_params
    params.require(:milestone).permit(:title, :due_date)
  end
end
