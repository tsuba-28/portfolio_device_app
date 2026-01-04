class CreateDeskSetupDevices < ActiveRecord::Migration[8.0]
  def change
    create_table :desk_setup_devices do |t|
      t.references :desk_setup, null: false, foreign_key: true
      t.references :device, null: false, foreign_key: true

      t.timestamps
    end
    add_index :desk_setup_devices, [ :desk_setup_id, :device_id ], unique: true
  end
end
