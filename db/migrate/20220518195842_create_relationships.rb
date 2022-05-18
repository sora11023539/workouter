class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end

    # 頻繁に検索するのでインデックスカラム追加
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    # 同じユーザーを二回フォローすることを防ぐ
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
