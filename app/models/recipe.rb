class Recipe < ActiveRecord::Base

	validates :recipe_no, uniqueness: true

	def self.by_no(a)
		self.where(recipe_no: a).first
	end

	def self.chef
		self.select{ |i| i.disciplines.include?("Chef") }
	end

	def get_output
		Item.where(item_no: output_item_no).first
	end

	def get_ingredients
		ing = YAML::load(ingredients)
		lista = []
		ing.each do |i|
			lista.push({item: Item.by_no(i["item_id"]), number: i["count"]})
		end
		return lista
	end

	def get_disciplines
		disc = []
		YAML::load(disciplines).each do |i|
			disc.push("#{i} (#{min_rating})")
		end
		disc = disc.to_s.delete("[]\"")
		disc[","] = " or" unless !disc.include?(",")
		disc
	end

	def get_recipe_item

	end


end
