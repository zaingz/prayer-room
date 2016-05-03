class Photo < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :room , :foreign_key => [:id, :version]
end
