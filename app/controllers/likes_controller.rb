class LikesController < ApplicationController

  def create
    @user = User.find(params[:id])
    Like.create(user_id: @user.id)
    # Like.create(user_id: @user.id)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def destroy
    @user = User.find(params[:id])
    Like.find_by(user_id: @user.id).destroy
    # Like.find_by(user_id: @user.id).destroy
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def show
    # @users = User.find_by(id: params[:id])
  end

end
