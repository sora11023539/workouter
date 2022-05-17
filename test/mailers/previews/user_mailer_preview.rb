# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/account_activation
  def account_activation
    user = User.first
    # アカウント有効化のトークンが必要
    # activation_tokenは仮の属性なので,dbのユーザーはこの値を持っていない
    user.activation_token = User.new_token
    # userが開発用dbの最初のユーザーになるよう定義
    UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/password_reset
  def password_reset
    UserMailer.password_reset
  end

end
