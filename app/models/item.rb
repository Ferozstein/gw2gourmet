class Item < ActiveRecord::Base

	validates :item_no, uniqueness: true

	has_many :votes
	has_many :comments

	scope :consumable, -> { where item_type: "Consumable" }
 	scope :all_ingredients, -> { Item.select{|i| [(i.crafting != nil), (i.craft_mat !=nil)].all?}.select{|i| i.craft_mat.include?("Chef")}.sort_by {|obj| obj.name} }
 	scope :food, -> { Item.consumable.to_a.select{ |i| i.type_elements.include?("Food")} }

	def get_recipe
		Recipe.where(recipe_no: recipe_no).first
	end

	def self.by_name(a) # uwaga na itemy o tych samych nazwach, kilka ich jest
		self.where(name: a).first
	end

	def self.by_no(a)
		self.where(item_no: a).first
	end

  	def find_item
		@item = Item.by_no(params[:id])
  	end

	def get_disciplines
		disc = []
		YAML::load(craft_mat).each do |key, value|
			disc.push("#{key} (#{value})")
		end
		disc.to_s.delete("[]\"")
	end


end
