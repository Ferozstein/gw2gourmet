class Item < ActiveRecord::Base

	validates :item_id, uniqueness: true

end
