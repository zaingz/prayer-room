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
counti = 0

data.each do |my_d|
	if my_d['post_type'] == 'attachment' || my_d['post_type'] == 'revision'
		user = User.create(email: "muhammad.tayyabmukhtar@yahoo.com" , password: "123456789")
		room = Room.create(user_id: user.id)
		version = Version.create(name: my_d['post_title'], street: "", floor: "", city: "", country: "", description: my_d['post_content'] , direction: "", room_id: room.id, status: 1, typ: 0 )
		photo = Photo.create(photo_url: my_d['guid'] , cloud: false , version_id: version.id)
		counti += 1
		data.each do |second_lop|
			if second_lop['post_parent'] == my_d['ID']
				versioni = Version.create(name: second_lop['post_title'], street: "", floor: "", city: "", country: "", description: second_lop['post_content'] , direction: "", room_id: room.id, status: 1, typ: 1 )
				photoo = Photo.create(photo_url: second_lop['guid'] , cloud: false , version_id: versioni.id)
				counti += 1
			end
		end
	end
end
p counti