require 'rails_helper'

# Userモデルのテスト
RSpec.describe User, type: :model do
  # ニックネーム,メールアドレス,パスワード（確認）があれば有効であること
  xit "is valid with a name, email, password, password_confirm" do
    expect(FactoryBot.create(:user)).to be_vaild
  end

  # ニックネームがなければ無効な状態であること
  it 'is invalid without a name' do
    user = FactoryBot.build(:user, name: nil)
    expect(user).not_to be_valid
  end

  # メールアドレスがなければ無効な状態であること
  it 'is invalid without an email address' do
    user = FactoryBot.build(:user, email: nil)
    expect(user).not_to be_valid
  end

  # 重複したメールアドレスの場合、無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "test@test.com")
    user = FactoryBot.build(:user, email: "test@test.com")
    expect(user).not_to be_valid
  end

  # パスワードが8文字以上なければ無効な状態であること
  it 'is invalid without a password that has less than 8 characters' do
    user = FactoryBot.build(:user, password: "passwor")
    expect(user).not_to be_valid
  end
end
