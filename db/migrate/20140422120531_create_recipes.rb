class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.integer :recipe_id
      t.string :recipe_type
      t.integer :output_item_id
      t.integer :output_item_count
      t.integer :min_rating
      t.integer :time_to_craft_ms
      t.string :disciplines
      t.string :flags
      t.string :ingredients

      t.timestamps
    end
  end
end
