class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def show
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(project_params)
    
    if @project.save
      flash.now[:success] = "Project successfully created."
    else
      flash.now[:error]  = "Project creation failed."
    end
  end

  private

  def project_params
    params.require(:project).permit(:title, :description, :due_date, :priority, :completed)
  end
end
