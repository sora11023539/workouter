require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe '#create' do
    context "If you can save" do
      # 全てのパラメーターが揃っていれば保存できる
      it "is have all the parameters, it can save it." do
        expect(FactoryBot.create(:relationship)).to be_valid
      end
    end

    context "If you can't save" do
      # follower_idがnilの場合は保存できない
      it "is can't save if follower_id is nil" do
        expect(FactoryBot.build(:relationship, follower_id: nil)).not_to be_valid
      end

      # followed_idがnilの場合は保存できない
      it "is can't save if followed_id is nil" do
        expect(FactoryBot.build(:relationship, followed_id: nil)).not_to be_valid
      end
    end

    context "uniqueness verification" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end

      # follower_idとfollowed_idの組み合わせは一意でなければ保存できない
      it "is the combination of follower_id and followed_id can only be saved if it is unique" do
        expect(FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @relation.followed_id)).not_to be_valid
      end

      # follower_idが同じでもfollowed_idが違うなら保存できる
      it "is even if the follower_id is the same, it can be saved if the followed_id is different" do
        expect(FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @user1.followed_id)).to be_valid
      end

      # follower_idが違うならfollowed_idが同じでも保存できる
      it "is if the follower_id is different, you can save even if the followed_id is the same" do
        expect(FactoryBot.build(:relationship, follower_id: @user1.follower_id, followed_id: @relation.followed_id)).to be_valid
      end
    end
  end

end
