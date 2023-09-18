class ProjectsController < ApplicationController
  before_action :select_project, except: %i[index create]

  def index
    @user = current_user
    @projects = Project.all
    @project = Project.new
  end

  def show
    @project = Project.includes(project_users: [:user], milestones: []).find(params[:id])
    @project_admin = @project.project_users.find_by(role: 'admin').user
    @milestone = Milestone.new
  end

  def create
    project = Project.new(project_params)
    
    respond_to do |format|
      if project.save
        current_user.project_users.create(project: project, role: 'admin')
        format.html { redirect_to project_path(project), notice: "Project successfully created." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "flash_container",
            partial: 'partials/projects/project_flash',
            locals: { errors: project.errors.full_messages, success: nil }
          )
        end
      end
    end
  end
  
  def destroy
    respond_to do |format|
      if @selected_project.destroy
        format.html { redirect_to projects_path, notice: "Project removed successfully." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "flash_container",
            partial: 'projects/project_flash',
            locals: { errors: @selected_project.errors.full_messages }
          )
        end
      end
    end
  end
  
  private

  def select_project
    @selected_project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :description, :due_date, :priority, :completed).merge(public: params[:public])
  end
end
