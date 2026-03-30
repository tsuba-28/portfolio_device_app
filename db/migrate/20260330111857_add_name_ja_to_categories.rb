class AddNameJaToCategories < ActiveRecord::Migration[8.0]
  def change
    add_column :categories, :name_ja, :string
  end
end
