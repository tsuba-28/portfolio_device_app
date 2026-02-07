class AddDetailsToDeskSetups < ActiveRecord::Migration[8.0]
  def change
    add_column :desk_setups, :style_id, :integer
    add_column :desk_setups, :pc_usage_id, :integer
  end
end
