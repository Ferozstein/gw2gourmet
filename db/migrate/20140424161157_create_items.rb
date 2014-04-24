class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :item_id
      t.string :name
      t.text :description
      t.string :item_type
      t.integer :level
      t.string :rarity
      t.integer :vendor_value
      t.string :icon_file_id
      t.string :icon_file_signature
      t.string :default_skin
      t.text :game_types
      t.text :flags
      t.text :restrictions
      t.text :type_elements
      t.text :crafting

      t.timestamps
    end
  end
end
