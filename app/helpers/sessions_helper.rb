module SessionsHelper
  # 渡されたユーザーでログインする
  # cookieにハッシュ化したuser.idを保存
  def log_in(user)
    session[:user_id] = user.id
  end

  # ユーザーのセッションを永続的に
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end


  # 現在ログイン中のユーザーを返す (いる場合)
  # cookieに保存されたuser.idを元に、userの情報を取得
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # 受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
  # ログイン中のuserにしか表示させたく無い時
  def current_user?(user)
    user && user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 永続的セッション破棄
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログアウト
  # cookieに保存されているuser.id削除
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # 記憶したURLにリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLを覚えておく
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

end
