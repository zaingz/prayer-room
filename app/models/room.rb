class Room < ActiveRecord::Base
	belongs_to :user
	has_many :versions
	has_many :checkins
end
