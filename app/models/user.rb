class User < ApplicationRecord
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # Userモデルにfollowingの関連付けをする
  # source following配列の元はfollowed id の集合
  has_many :following, through: :active_relationships, source: :followed
  # Userモデルにfollowersの関連付けをする
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token, :activation_token, :reset_token
  # saveする前に小文字に変換
  before_save :downcase_email
  before_create :create_activation_digest

  # userがdbに保存される前にname,emailフィールドが存在するか
  validates :name, presence: true, length: { maximum: 100 }

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

  # トークンがダイジェストと一致したらtrueを返す
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # アカウント有効化
  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  # 有効化用のメール送信
  def send_activation_email
    # deliver_now すぐに送信
    UserMailer.account_activation(self).deliver_now
  end

  # pass再設定の属性を設定する
  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # pass再設定のメール送信
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # パス再設定の期限が切れている場合はtrue
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
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
