class AddRecipeIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :recipe_id, :integer
    add_column :items, :craft_mat, :string
  end
end
