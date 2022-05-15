class AddIndexToUsersEmail < ActiveRecord::Migration[6.1]
  def change
    # add_index 指定したtebleにindexを追加
    add_index :users, :email, unique: true
  end
end
