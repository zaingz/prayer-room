class Room < ActiveRecord::Base
	self.primary_keys = :id, :version
	enum status: [ :pending , :approved , :rejected]
	has_many :photos , dependent: :destroy
	accepts_nested_attributes_for :photos
	has_many :reports , dependent: :destroy , :foreign_key => [:id, :version]
	has_many :checkins , :foreign_key => [:id, :version]
	belongs_to :user
	has_many :voteups , :foreign_key => [:id, :version]


	scope :pending , lambda {where(:status => 0)}
	scope :approve_reject , lambda {where.not(:status => 0)}
end
