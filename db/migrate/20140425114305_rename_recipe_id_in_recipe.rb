class RenameRecipeIdInRecipe < ActiveRecord::Migration
  def change

  	rename_column :recipes, :recipe_id, :recipe_no
  	rename_column :items, :item_id, :item_no

  end
end
