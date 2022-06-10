require 'rails_helper'

# Userモデルのテスト
describe User do
  # createメソッドである
  describe '#create' do
    it "nameがない場合は登録できないこと" do
      # user作成 nameは空に
      user = FactoryBot.build(:user, name: nil)
      # バリデーションにより保存ができない状態か
      user.valid?
      # を入力してください というエラーが出るか
      expect(user.errors[:name]).to include("を入力してください")
    end
  end
end
