# Jak resetować tabelę przy generowaniu nowego seeda tak żeby
# np. id zaczynały się za każdym razem od 1:
# używać gemu DatabaseCleaner, o tak:
# 
# DatabaseCleaner.clean_with(:truncation, :only => 'yourtablename')
# (zresetowanie jednej tabeli);
# DatabaseCleaner.clean_with(:truncation, :only => ['table1', 'table2', 'table3'])
# (kilku tabel), albo:
# DatabaseCleaner.clean_with(:truncation)
# (lecimy po całości - i tego będę domyślnie tu używał).

require 'yaml'
require 'json'
require 'timeout'

counter = 16912

# begin
# przepisy = Timeout::timeout(30) {

# 	gw2 = Gw2Api.new

# 	r = JSON.parse(gw2.recipes)
	
# 	counter.times do
# 		r["recipes"].delete(r["recipes"].first)
# 	end
# 	#puts "#{r["recipes"].length} recipes remaining"

# 	r["recipes"].each do |i|
# 		gw2 = Gw2Api.new
# 		a = JSON.parse(gw2.recipe_details(i))
# 		#if a["disciplines"].include?("Chef")
# 				recipe = Recipe.new(
# 				recipe_id: a["recipe_id"].to_i,
# 				recipe_type: a["type"],
# 				output_item_id: a["output_item_id"].to_i,
# 				output_item_count: a["output_item_count"].to_i,
# 				min_rating: a["min_rating"].to_i,
# 				time_to_craft_ms: a["time_to_craft_ms"].to_i,
# 				disciplines: YAML::dump(a["disciplines"]),
# 				flags: YAML::dump(a["flags"]),
# 				ingredients: YAML::dump(a["ingredients"]),
# 				)
# 			recipe.save
# 			counter += 1
# 			puts "#{counter} recipes added"
# 		#end
# 	end
# }
# rescue Timeout::Error, Errno::ETIMEDOUT
# 	puts "Operation timed out, retrying..."
# 	retry
# end


begin
przedmioty = Timeout::timeout(30) {

	gw2 = Gw2Api.new

 	p = JSON.parse(gw2.items)
	
	p["items"] = p["items"] - p["items"].first(counter)

 	p["items"].each do |i|
 		gw2 = Gw2Api.new
 		a = gw2.item_details(i)
 		item = ItemString.new(
 			item_id: i,
 			contents: YAML::dump(JSON.parse(a))
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
