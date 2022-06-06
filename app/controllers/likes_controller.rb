class LikesController < ApplicationController
  before_action :user_params

  def create
    Like.create(user_id: current_user.id)
  end

  def destroy
    Like.find_by(user_id: current_user.id).destroy
  end

  private

  def user_params
    @user = User.find(params[:id])
  end

end
