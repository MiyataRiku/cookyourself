class CreateRecipes < ActiveRecord::Migration[7.2]
  def change
    create_table :recipes do |t|
      t.integer :kcal
      t.integer :nut
      t.integer :time
      t.text :process
      t.string :material
      t.integer :price
      t.string :name

      t.timestamps
    end
  end
end
