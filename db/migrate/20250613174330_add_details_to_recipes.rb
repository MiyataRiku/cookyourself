class AddDetailsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :tips, :text
  end
end
