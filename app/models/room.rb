class Room < ActiveRecord::Base
	enum status: [ :pending , :approved]
	has_many :photos , dependent: :destroy
	accepts_nested_attributes_for :photos
	has_many :reports , dependent: :destroy
	belongs_to :user

end
