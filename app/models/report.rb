class Report < ActiveRecord::Base
	belongs_to :room
	enum status: [:no_longer_exist , :under_renovation , :inappropriate_content]
	belongs_to :reporter, :class_name => 'User'
end
