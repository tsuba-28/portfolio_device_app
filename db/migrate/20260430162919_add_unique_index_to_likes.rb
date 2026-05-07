class AddUniqueIndexToLikes < ActiveRecord::Migration[8.0]
  def change
    add_index :likes, [:user_id, :desk_setup_id], unique: true
  end
end
