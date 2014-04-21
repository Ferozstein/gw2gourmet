# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'yaml'

items = GW2::Item.all

items["items"].foreach do |i|
	a = GW2::Item.details(i)
	item = ItemString.new(contents: YAML::dump(a), item_id: i)
	item.save
end