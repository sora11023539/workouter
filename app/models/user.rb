class User < ApplicationRecord
  # saveする前に小文字に変換
  before_save { self.email = email.downcase }

  # userがdbに保存される前にname,emailフィールドが存在するか
  validates :name, presence: true, length: { maximum: 10 }

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
  validates :password, presence :true, length: { minimum: 8 }
end
