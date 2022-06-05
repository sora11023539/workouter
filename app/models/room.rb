class Room < ApplicationRecord
  has_many :chats
  # 1つのルームにいるユーザー数は2人なのでhas_many
  # user_rooms usersテーブルとroomsテーブルの中間テーブル
  has_many :user_rooms
  has_many :users, through: :user_rooms, source: :user
end
