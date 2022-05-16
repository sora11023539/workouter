class SessionsController < ApplicationController
  # viewファイルが必要なのはnewのみなので、それ以外は手動で生成
  def new
  end

  # ログイン処理を行う
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate(params[:session][:password])
      log_in user
      remember user
      redirect_to user
    else
      flash.now[:danger] = 'ログインに失敗'
      render 'new'
    end
  end

  # cookieに保存されたuser.idを削除し、ログアウト
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
