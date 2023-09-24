class UsersController < ApplicationController
  def show
    @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
