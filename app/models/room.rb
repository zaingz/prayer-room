class Room < ActiveRecord::Base
	enum status: [ :pending , :approved , :rejected]
	has_many :photos , dependent: :destroy
	accepts_nested_attributes_for :photos
	has_many :reports , dependent: :destroy
	has_many :checkins
	belongs_to :user


	scope :pending , lambda {where(:status => 0)}
	scope :approve_reject , lambda {where.not(:status => 0)}
end
