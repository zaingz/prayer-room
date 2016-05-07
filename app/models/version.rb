class Version < ActiveRecord::Base
	enum status: [ :pending , :approved , :rejected]
	enum typ: [:newly , :edited]
	has_many :photos , dependent: :destroy
	accepts_nested_attributes_for :photos
	has_many :reports , dependent: :destroy
	has_many :voteups
	belongs_to :room

	scope :pending , lambda {where(:status => 0)}
	scope :approve_reject , lambda {where.not(:status => 0)}
end
