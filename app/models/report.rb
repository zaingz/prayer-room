class Report < ActiveRecord::Base
	belongs_to :room , :foreign_key => [:id, :version]
	enum status: [:no_longer_exist , :under_renovation , :inappropriate_content]
	belongs_to :reporter, :class_name => 'User'

	scope :no_longer_exist , lambda{ where(:status => 0)}
	scope :under_renovation , lambda{ where(:status => 1)}
	scope :inappropriate_content , lambda{ where(:status => 2)}
end
