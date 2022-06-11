require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { FactoryBot.create(:relationship) }
  describe "#create" do

    context "uniqueness verification" do

      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end

      # follower_idとfollowed_idの組み合わせは一意でなければ保存できない
      it "is the combination of follower_id and followed_id can only be saved if it is unique" do
        relation2 = FactoryBot.build(:relationship, followed_id: @relation.followed_id, followed_id: @relation.followed_id)
        relation2.not_to be_vaild
      end

    end
  end

end
