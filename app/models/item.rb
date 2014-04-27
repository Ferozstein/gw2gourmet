class Item < ActiveRecord::Base

	validates :item_no, uniqueness: true

	has_many :votes
	has_many :comments

	def get_recipe
		Recipe.where(recipe_no: recipe_no).first
	end

	def self.by_name(a) # uwaga na itemy o tych samych nazwach, kilka ich jest
		self.where(name: a).first
	end

	def self.by_no(a)
		self.where(item_no: a).first
	end

	scope :consumable, -> { where item_type: "Consumable" }

	def self.food
		Item.consumable.to_a.select{ |i| i.type_elements.include?("Food")}
	end

	def get_disciplines
		disc = []
		YAML::load(craft_mat).each do |key, value|
			disc.push("#{key} (#{value})")
		end
		disc.to_s.delete("[]\"")
	end


end
