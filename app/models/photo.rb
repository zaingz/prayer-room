class Photo < ActiveRecord::Base
	mount_uploader :image, ImageUploader
	belongs_to :version
end
