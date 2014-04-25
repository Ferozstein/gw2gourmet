class Recipe < ActiveRecord::Base

	validates :recipe_no, uniqueness: true

	def self.chef
		self.select{|i|
			i.disciplines.include?("Chef")
		}
	end

	def get_output
		Item.where(item_no: output_item_no).first
	end

	def get_ingredients
		ing = YAML::load(ingredients)
		lista = []
		ing.each do |i|
			lista.push(Item.where(item_no: i["item_id"]).first)
		end
		return lista
	end

	def get_recipe_item

	end


end
