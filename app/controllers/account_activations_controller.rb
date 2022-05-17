class AccountActivationsController < ApplicationController

  # アカウント有効化
  def edit
    user = User.find_by(email: params[:email])
    # 一度有効化しているアカウントを再度有効化させない
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      # アカウント有効化
      user.activate
      # ログイン
      log_in user
      flash[:success] = "アカウント有効化しました"
      redirect_to user
    else
      flash[:danger] = "無効なリンクです"
      redirect_to root_url
    end
  end

end
