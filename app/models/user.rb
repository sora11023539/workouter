class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  # saveする前に小文字に変換
  before_save :downcase_email
  before_create :create_activation_digest

  # userがdbに保存される前にname,emailフィールドが存在するか
  validates :name, presence: true, length: { maximum: 12 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    # email被らないように
                    # case_sensitive 大文字小文字区別
                    uniqueness: { case_sensitive: false }

  # セキュアにハッシュしたpassを,db内のpassword_digestに保存できる
  # 仮想的な属性passwordとpassword_confirmationが使える また存在性と値が一致するかのバリデーションも追加される
  # authenticatedメソッドが使える
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, allow_nil: true

  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
                                                  BCrypt::Password.create(string, cost: cost)
  end

  # ランダムなトークンを返す
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをdbに記憶
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたトークンがダイジェストと一致したらtrue返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # ログイン状態を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end

  private

    # emailを小文字に変換
    def downcase_email
      self.email = email.downcase
    end

    # 有効化トークンとダイジェストを作成及び代入
    def create_activation_digest
      self.activation_token = User.new_token
      self.activation_digest = User.digest(activation_token)
    end

end
