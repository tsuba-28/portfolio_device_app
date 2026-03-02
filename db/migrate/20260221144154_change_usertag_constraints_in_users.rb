class ChangeUsertagConstraintsInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_null :users, :usertag, false

    add_index :users, :usertag
  end
end
