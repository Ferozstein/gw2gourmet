class AddItemIdToItemString < ActiveRecord::Migration
  def change
    add_column :item_strings, :item_id, :integer
  end
end
