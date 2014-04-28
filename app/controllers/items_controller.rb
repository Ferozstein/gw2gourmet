class ItemsController < ApplicationController
  
  before_action :find_item, :only => [:show]

  def search

  end

  def find_item
    @item = Item.by_no(params[:id])
  end

  def search_results
  	if params[:boost] == "Any"
  		params[:boost] = " "
    elsif params[:boost] == "Burning duration"
      params[:boost] = "urning"
    elsif params[:boost] == "Chill duration"
      params[:boost] = "ill duration"      
    elsif params[:boost] == "Condition duration"
      params[:boost] = "ondition duration"
  	elsif params[:boost] == "Chill"
  		params[:boost] = "cause chill"
  	elsif params[:boost] == "Condition removal"
  		params[:boost] = "remove a condition"
  	elsif params[:boost] == "Condition damage"
  		params[:boost] = "ondition damage"
  	elsif params[:boost] == "Damage bonus"
  		params[:boost] = "amage while moving"
	elsif params[:boost] == "Downed damage"
  		params[:boost] = "amage while downed"
  elsif params[:boost] == "Downed health"
      params[:boost] = "owned health"
	elsif params[:boost] == "Gold find"
  		params[:boost] = "from monsters"
  elsif params[:boost] == "Healing power"
      params[:boost] = "ealing"
	elsif params[:boost] == "Gain health on kill"
  		params[:boost] = "gain health"
 	elsif params[:boost] == "Karma gain"
  		params[:boost] = "karma"
 	elsif params[:boost] == "Lifesteal"
  		params[:boost] = "steal life"
 	elsif params[:boost] == "Karma gain"
  		params[:boost] = "karma"
  elsif params[:boost] == "Might"
      params[:boost] = "ight "
  elsif params[:boost] == "Magic find"
      params[:boost] = "agic "
 	elsif params[:boost] == "Regeneration"
  		params[:boost] = "very second"
  elsif params[:boost] == "Poison duration"
      params[:boost] = "oison "
  elsif params[:boost] == "Power"
      params[:boost] = "ower "
  elsif params[:boost] == "Precision"
      params[:boost] = "recision"
  elsif params[:boost] == "Stun duration"
      params[:boost] = "tun "
  elsif params[:boost] == "Swiftness"
      params[:boost] = "wiftness "
  elsif params[:boost] == "Toughness"
      params[:boost] = "ough"
  elsif params[:boost] == "Vitality"
      params[:boost] = "ality"
 	else
  		params[:boost].delete(params[:boost][0])
  	end

  	if params[:duration] == "Any"
  		params[:duration] = "ms: '"
  	else
  		params[:duration] = "ms: '#{params[:duration].delete(" minutes").to_i * 60000}"
  	end

  	if params[:exp] == "Any"
  		params[:exp] = "Experience"
  	else
  		params[:exp] += " Experience"
  	end

  	if params[:maxlevel] == ""
  		params[:maxlevel] = "80"
  	end

  	if params[:minlevel] == ""
  		params[:minlevel] = "0"
  	end

  	if params[:name] == ""
  		params[:name] = " "
  	end

  	@result = Item.food.select{|i|
  		[(i.name+" ").include?(params[:name]),
  		i.type_elements.include?(params[:boost]),
  		i.level >= params[:minlevel].to_i,
  		i.level <= params[:maxlevel].to_i,
  		i.type_elements.include?(params[:duration]),
  		i.type_elements.include?(params[:exp])].all?
  	}.sort_by {|obj| obj.level}.reverse

  	@submitted = true

  	render 'search'
  end

  def recipe
    @ingredient_names = []
    Item.all_ingredients.each do |i|
      @ingredient_names.push(i.name)
    end
  end

  def recipe_results
    @ingredient_names = []
    Item.all_ingredients.each do |i|
      @ingredient_names.push(i.name)
    end
    @item = Item.by_name(params[:ingredient])
    @recipes = Recipe.select{|i| i.ingredients.include?(@item.item_no.to_s)}.sort_by {|obj| obj.min_rating}.reverse
    render 'recipe'
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @comments = @item.comments
  end



end
