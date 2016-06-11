# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'json'

file = File.read('db/pray.json')
data = JSON.parse(file)
count = 0

data.each do |my_d|
	if my_d['post_type'] == 'attachment'
		#room = Room.create(user_id: 1)
		#version = Version.create(name: my_d['post_title'], street: "", floor: "", city: "", country: "", description: my_d['post_content'] , direction: "", room_id: room.id, status: 0, typ: 0 )
		count += 1
	end
end
p count