class CreateDeskSetups < ActiveRecord::Migration[8.0]
  def change
    create_table :desk_setups do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false

      t.timestamps
    end
  end
end
