require 'rails_helper'

RSpec.describe Relationship, type: :model do
  
  describe "#create" do
    context "uniqueness verification" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user = FactoryBot.build(:relationship)
      end

      # follower_idとfollowed_idの組み合わせは一意でなければ保存できない
      xit "is the combination of follower_id and followed_id can only be saved if it is unique" do
        relation2 = FactoryBot.build(:relationship, followed_id: @relation.followed_id, followed_id: @relation.followed_id)
        expect(relation2).not_to be_vaild
      end

      # follower_idが同じでもfollowed_idが違うなら保存できる
      it "is even if the follower_id is the same, it can be saved if the followed_id is different." do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @user.followed_id)
        expect(relation2).to be_valid
      end

      # follower_idが違うならfollowed_idが同じでも保存できる
      it "is if the follower_id is different, you can save even if the followed_id is the same" do
        relation2 = FactoryBot.build(:relationship, follower_id: @user.follower_id, followed_id: @relation.followed_id)
        expect(relation2).to be_valid
      end
    end
  end

end
