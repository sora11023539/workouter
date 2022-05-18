class Relationship < ApplicationRecord
  # relationship/followerに対して関連付け
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # 各属性に値があるか
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
