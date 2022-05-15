class CreateUsers < ActiveRecord::Migration[6.1]
  # changeメソッド userを保存するためのtableをdbに作成
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
