class ProjectUsersController < ApplicationController

  def create
    @user_ids = params[:user_ids]
    project_id = params[:project_id]

    @user_ids&.each do |id|
      ProjectUser.create(project_id: , user_id: id.to_i)
    end

    @project_users = ProjectUser.where(project_id: params[:project_id])

    respond_to do |format|
      format.turbo_stream
    end
  end

  def destroy
    @project_user = ProjectUser.find(params[:id]).destroy
    @project_users = ProjectUser.where(project_id: @project_user.project_id)

    respond_to do |format|
      format.turbo_stream
    end
  end
end
