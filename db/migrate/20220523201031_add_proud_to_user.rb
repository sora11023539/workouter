class AddProudToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :proud, :string
  end
end
