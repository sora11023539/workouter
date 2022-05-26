class AddAddressToUser < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.integer :address, null: false, default: 0
    end
  end
end
