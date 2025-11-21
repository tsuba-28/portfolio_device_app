class AddUsertagToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :usertag, :string

    add_index :users, [:username, :usertag], unique: true
  end
end
