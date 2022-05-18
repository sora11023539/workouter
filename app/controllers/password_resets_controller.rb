class PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  # パス再設定の有効期限が切れていないか
  before_action :check_expiration, only: [:edit, :update]

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

  def update
    # 新しいパスワードが空になっていないか
    if params[:user][:password].empty?
      @user.errors.add(:password, :blank)
      render 'edit'
    # 新しいパスが正しければ更新する
    elsif @user.update(user_params)
      log_in @user
      # 再設定完了したらnilにする
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "パスワードが変更されました"
      redirect_to @user
    # 無効なパスであれば失敗
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
      @user = User.find_by(email: params[:email])
    end

    # 正しいユーザーかどうか確認
    def valid_user
      unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end

    # トークンが期限切れか
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "パスワード再設定の有効期限が切れました。"
        redirect_to new_password_reset_url
      end
    end

end
