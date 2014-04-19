class CreateItemStrings < ActiveRecord::Migration
  def change
    create_table :item_strings do |t|
      t.string :contents

      t.timestamps
    end
  end
end
