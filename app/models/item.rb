class Item < ActiveRecord::Base

	validates :item_no, uniqueness: true

	def get_recipe
		Recipe.where(recipe_no: recipe_no).first
	end

	def self.by_name(a)
		self.where(name: a).first
	end

	def self.by_no(a)
		self.where(item_no: a).first
	end

	def self.consumable
		self.where(item_type: "Consumable").to_a
	end

	def self.food
		food = []
		self.consumable.select{ |i|
			if i.type_elements != nil
				food.push(i) if YAML::load(i.type_elements)["type"] == "Food"
			end
		}
		return food
	end


end
