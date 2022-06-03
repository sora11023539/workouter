class AddAddressToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :address, :integer, null: false, default: 0
  end
end
