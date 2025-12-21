class CreateDevices < ActiveRecord::Migration[8.0]
  def change
    create_table :devices do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name, null: false
      t.string :brand_name
      t.text :description
      t.string :slug, null: false

      t.timestamps
    end
    add_index :devices, :slug, unique: true
  end
end
