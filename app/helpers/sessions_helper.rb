module SessionsHelper
  # 渡されたユーザーでログインする
  # cookieにハッシュ化したuser.idを保存
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  # cookieに保存されたuser.idを元に、userの情報を取得
  def current_user
    if session[:user_id]
      # @current_user = @current_user || User.find_by(id: session[:user_id])と同じ意味
      # findだとuser.idが存在しないと例外が返される find_byだとnil
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # 受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
  # ログイン中のuserにしか表示させたく無い時
  def current_user?(user)
    user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # ログアウト
  # cookieに保存されているuser.id削除
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
