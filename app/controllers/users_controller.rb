class UsersController < ApplicationController
  before_action :find_user, except: [:create]

  def show
    @user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    respond_to do |format|
      if @user.update(user_params)
        format.html
      else
        format.turbo_stream
      end
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:profession, :full_name, :bio, :image)
  end
end
