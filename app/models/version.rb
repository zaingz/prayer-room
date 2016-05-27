class Version < ActiveRecord::Base
	enum status: [ :pending , :approved , :rejected]
	enum typ: [:newly , :edited]
	has_many :photos , dependent: :destroy
	accepts_nested_attributes_for :photos
	has_many :reports , dependent: :destroy
	has_many :voteups , dependent: :destroy
	belongs_to :room

	scope :pending , lambda {where(:status => 0)}
	scope :approve_reject , lambda {where.not(:status => 0)}
	scope :approve , lambda {where(:status => 1)}
	scope :better , lambda{where.not(typ: 'newly')}
	scope :orignal , lambda{where(typ: 'newly')}
	scope :decending , lambda{ order(created_at: :desc)}

	attr_accessor :name_d

end
