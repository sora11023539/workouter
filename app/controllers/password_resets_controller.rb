class PasswordResetsController < ApplicationController
  def new
  end

  def create
    # emailをキーとしてユーザーを見つける
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      # pass再設定トークン更新
      @user.create_reset_digest
      # 再設定のメール送信
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
  end
end
