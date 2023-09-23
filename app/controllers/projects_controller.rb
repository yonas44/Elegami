class ProjectsController < ApplicationController
  before_action :select_project, except: %i[index create]

  def index
    @user = current_user
    @projects = Project.all
    @project = Project.new
  end

  def edit
    @project = Project.find(params[:id])
  end

  def show
    @project = Project.includes(project_users: [:user], milestones: []).find(params[:id])
    @project_admin = @project.project_users.find_by(role: 'admin').user
    @new_milestone = Milestone.new
    @task = Task.new
    @project_user = ProjectUser.new
  
    # Query for users not associated with the project
    @non_members = User.where.not(id: @project.project_users.pluck(:user_id))
  end

  def create
    @project = Project.new(project_params)
    
    respond_to do |format|
      if @project.save
        current_user.project_users.create(project: @project, role: 'admin')
        format.html { redirect_to project_path(@project), notice: "Project successfully created." }
      else
        format.turbo_stream
      end
    end
  end

  def update
    @project = Project.find(params[:id])
    
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_path(@project), notice: "Project updated!" }
      else
        format.turbo_stream
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
            partial: 'shared/flash',
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
    params.require(:project).permit(:title, :description, :start_date, :due_date, :priority, :public, :completed)
  end
end
