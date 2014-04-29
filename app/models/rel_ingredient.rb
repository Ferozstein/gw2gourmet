class RelIngredient < ActiveRecord::Base

	belongs_to :ingredient :class => :recipe
	belongs_to :recipe

end
