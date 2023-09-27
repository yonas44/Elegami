class ProjectUsersController < ApplicationController
  load_and_authorize_resource

  def create
    @user_ids = params[:user_ids]
    ProjectUser.create!(@user_ids.map { |id| project_user_params.merge(user_id: id.to_i) })

    @project_users = ProjectUser.where(project_id: project_user_params[:project_id])

    respond_to(&:turbo_stream)
  end

  def destroy
    @project_user = ProjectUser.find(params[:id]).destroy
    @project_users = ProjectUser.where(project_id: @project_user.project_id)

    respond_to(&:turbo_stream)
  end

  private

  def project_user_params
    params.require(:project_user).permit(:project_id)
  end
end
