class Voteup < ActiveRecord::Base
	belongs_to :user
	belongs_to :room , :foreign_key => [:id, :version]
end
