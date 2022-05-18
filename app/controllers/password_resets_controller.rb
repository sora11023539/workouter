class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]

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
      flash[:info] = "パスワード再設定メールを送信しました"
      redirect_to root_url
    else
      flash.now[:danger] = "メールアドレスが見つかりません"
      render 'new'
    end
  end

  def edit
  end

  private

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

end
