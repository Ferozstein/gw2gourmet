require 'yaml'
require 'timeout'

counter = 0

# Wszystko dalej jest wykomentowane, żeby nie odpalić tego przez pomyłkę wpisując
# rake db:seed zamiast migracji. Każda z poniższych operacji zajmuje kilka(naście)
# godzin. Zostały już raz puszczone, dane są w bazie i lepiej tego nie powtarzać
# bez wyraźnej potrzeby.


#pobranie przepisów do bazy z API
=begin

begin
przepisy = Timeout::timeout(30) {

	gw2 = Gw2Api.new

	r = YAML::load(gw2.recipes)
	
	counter.times do
		r["recipes"].delete(r["recipes"].first)
	end
	#puts "#{r["recipes"].length} recipes remaining"

	r["recipes"].each do |i|
		gw2 = Gw2Api.new
		a = YAML::load(gw2.recipe_details(i))
		#if a["disciplines"].include?("Chef")
				recipe = Recipe.new(
				recipe_no: a["recipe_id"].to_i,
				recipe_type: a["type"],
				output_item_no: a["output_item_id"].to_i,
				output_item_count: a["output_item_count"].to_i,
				min_rating: a["min_rating"].to_i,
				time_to_craft_ms: a["time_to_craft_ms"].to_i,
				disciplines: YAML::dump(a["disciplines"]),
				flags: YAML::dump(a["flags"]),
				ingredients: YAML::dump(a["ingredients"]),
				)
			recipe.save
			counter += 1
			puts "#{counter} recipes added"
		#end
	end
}
rescue Timeout::Error, Errno::ETIMEDOUT
	puts "Operation timed out, retrying..."
	retry
end

=end

# pobranie przedmiotów z API do bazy, w postaci JSONa
=begin

begin
przedmioty = Timeout::timeout(30) {

	gw2 = Gw2Api.new

 	p = YAML::load(gw2.items)
	
	p["items"] = p["items"] - p["items"].first(counter)

 	p["items"].each do |i|
 		gw2 = Gw2Api.new
 		a = gw2.item_details(i)
 		item = ItemString.new(
 			item_id: i,
 			contents: YAML::dump(YAML::load(a))
		)
 		item.save
 		counter += 1
 		puts "#{counter} items added"
 	end
}
rescue Timeout::Error, Errno::ETIMEDOUT#, ActiveRecord::ActiveRecordError, NoMethodError, StandardError, Exception
 	puts "Operation timed out, retrying..."
 	retry
end

=end

# przerabia JSONy przedmiotów na sensowniejsze (i łatwiej przeszukiwalne) parametry
=begin

ItemString.find_each do |i|
	stats = YAML::load(i.contents)
	
	item = Item.new(
		item_no: stats["item_id"].to_i,
		name: stats["name"],
		item_type: stats["type"],
		level: stats["level"].to_i,
		rarity: stats["rarity"],
		vendor_value: stats["vendor_value"].to_i,
		icon_file_id: stats["icon_file_id"],
		icon_file_signature: stats["icon_file_signature"],
		default_skin: stats["default_skin"],
		game_types: YAML::dump(stats["game_types"]),
		flags: YAML::dump(stats["flags"]),
		restrictions: YAML::dump(stats["restrictions"])
	)

	item.description = stats["description"] if stats.has_key?("description")
	item.type_elements = YAML::dump(stats["armor"]) if stats.has_key?("armor")
	item.type_elements = YAML::dump(stats["back"]) if stats.has_key?("back")
	item.type_elements = YAML::dump(stats["bag"]) if stats.has_key?("bag")
	item.type_elements = YAML::dump(stats["consumable"]) if stats.has_key?("consumable")
	item.type_elements = YAML::dump(stats["container"]) if stats.has_key?("container")
	item.type_elements = YAML::dump(stats["gathering"]) if stats.has_key?("gathering")
	item.type_elements = YAML::dump(stats["gizmo"]) if stats.has_key?("gizmo")
	item.type_elements = YAML::dump(stats["tool"]) if stats.has_key?("tool")
	item.type_elements = YAML::dump(stats["trinket"]) if stats.has_key?("trinket")
	item.type_elements = YAML::dump(stats["upgrade_component"]) if stats.has_key?("upgrade_component")
	item.type_elements = YAML::dump(stats["weapon"]) if stats.has_key?("weapon")

	item.save
end

=end

# dopisuje do itemów dane o przepisach na nie i o byciu składnikami oraz numery
# przepisów, w których występują jako składniki (w polu crafting, jako tablica)

=begin
Recipe.find_each do |przepis|
	out_item = Item.where(item_no: przepis.output_item_no).first
	out_item.recipe_no = przepis.recipe_no
	out_item.save

	ing = YAML::load(przepis.ingredients)
	disc = YAML::load(przepis.disciplines)
	
	ing.each do |skladnik|
		s = Item.where(item_no: skladnik["item_id"]).first
		if s.craft_mat == nil
			craft = {}
			disc.each do |dyscyplina|
				craft[dyscyplina] = przepis.min_rating
			end
		else
			craft = YAML::load(s.craft_mat)
			disc.each do |dyscyplina|
				if craft.select {|a| a[dyscyplina]}.empty?
					craft[dyscyplina] = przepis.min_rating
				else
					if craft[dyscyplina] > przepis.min_rating
						craft[dyscyplina] = przepis.min_rating
					end
				end
			end
		end
		s.craft_mat = YAML::dump(craft)

		if s.crafting.nil?
			s.crafting = YAML::dump([przepis.recipe_no])
		else
			crafting = YAML::load(s.crafting)
			crafting.push przepis.recipe_no
			s.crafting = YAML::dump(crafting)
		end
		s.save
	end
	counter += 1
	puts "#{counter} recipes processed."
end
=end