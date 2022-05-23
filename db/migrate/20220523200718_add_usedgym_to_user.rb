class AddUsedgymToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :usedgym, :string
  end
end
