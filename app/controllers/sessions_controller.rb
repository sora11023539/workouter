class SessionsController < ApplicationController
  # viewファイルが必要なのはnewのみなので、それ以外は手動で生成
  def new
  end

  # ログイン処理を行う
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # アカウントが有効化されているか
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or users_url
      else
        message = "アカウントが有効化されていません"
        message += "メールボックスの有効化リンクを確認してください"
        flash[:warning] = message
        redirect_to 'new'
      end
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render 'new'
    end
  end

  # cookieに保存されたuser.idを削除し、ログアウト
  def destroy
    log_out if logged_in?
    render 'new'
  end
end
