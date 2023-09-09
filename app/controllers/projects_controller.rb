class ProjectsController < ApplicationController
  before_action :select_project, except: %i[index create]

  def index
    @user = current_user
    @projects = Project.all
    @project = Project.new
    @new_project = session.delete(:new_project)
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    project = Project.new(project_params)
  
    respond_to do |format|
      if project.save
        # format.turbo_stream
        session[:new_project] = project
        format.html { redirect_to projects_path, notice: "Project successfully created." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(
            "flash_container",
            partial: 'projects/project_flash',
            locals: { errors: project.errors.full_messages, success: nil }
          )
        end
        # format.html { error: "Error creating project." }
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
    params.require(:project).permit(:title, :description, :due_date, :priority, :completed)
  end
end
