class CreateRelIngredients < ActiveRecord::Migration
  def change
    create_table :rel_ingredients do |t|
      t.integer :recipe_id
      t.integer :ingredient_id
      t.integer :ingredient_qty

      t.timestamps
    end
  end
end
