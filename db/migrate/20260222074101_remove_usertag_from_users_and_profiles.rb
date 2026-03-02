class RemoveUsertagFromUsersAndProfiles < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :usertag, :string

    remove_column :profiles, :usertag, :string
  end
end
