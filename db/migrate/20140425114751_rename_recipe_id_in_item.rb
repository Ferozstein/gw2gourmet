class RenameRecipeIdInItem < ActiveRecord::Migration
  def change
  	rename_column :recipes, :output_item_id, :output_item_no
  	rename_column :items, :recipe_id, :recipe_no
  end
end
