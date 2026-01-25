class CreateStyles < ActiveRecord::Migration[8.0]
  def change
    create_table :styles do |t|
      t.string :name,      null: false
      t.string :slug,      null: false
      t.integer :position, null: false, default: 0

      t.timestamps
    end

    add_index :styles, :slug, unique: true
  end
end
