# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# メインのサンプルユーザーを1 人作成する
User.create!(
  name: "master",
  email: "master@test.com",
  password: "P@ssw0rd01",
  password_confirmation: "P@ssw0rd01",

  avatar: File.open('./app/assets/images/master_user.jpg'),
  address: "広島",
  birthday: Time.parse("1996/11/02"),
  gendar: 0,
  height: 170,
  weight: 70,
  proud: "表情筋",
  introduction: "広島県のエニタイムフィットネスでトレーニングしております、
                  丸佳浩と申します。
                  筋トレ歴は4年です。

                  宜しくお願いしまっちょ。",
  usedgym: "エニタイムフィットネス",

  admin: true,
  activated: true,
  activated_at: Time.zone.now
)

# user生成
30.times do |n|
  name = Faker::Name.name
  email = "user-#{n+1}@test.com"
  password = "P@ssw0rd01"
  User.create!(
    name: name,
    email: email,
    password: password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now
  )
end

# relationships作成
users = User.all
user = users.first
following = users[2..30]
followers = users[3..20]
following.each{ |followed| user.follow(followed) }
followers.each{ |follower| follower.follow(user) }
