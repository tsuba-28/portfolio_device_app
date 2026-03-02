class AddUsertagToProfile < ActiveRecord::Migration[8.0]
  def change
    add_column :profiles, :usertag, :string, null: false, default: ""
  end
end
