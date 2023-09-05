class ProjectsController < ApplicationController
  def index
    @user = current_user
    @projects = Project.all
    @project = Project.new
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
  
    respond_to do |format|
      if @project.save
        # format.turbo_stream
        format.html { redirect_to projects_path, notice: "Project successfully created." }
      else
        # format.turbo_stream
        # format.html { error: "Error creating project." }
      end
    end
  end
  

  private

  def project_params
    params.require(:project).permit(:title, :description, :due_date, :priority, :completed)
  end
end
