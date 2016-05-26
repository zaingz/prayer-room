class Room < ActiveRecord::Base
	belongs_to :user
	has_many :versions , dependent: :destroy
	has_many :checkins , dependent: :destroy

	scope :decending , lambda{ order(created_at: :desc)}
end
