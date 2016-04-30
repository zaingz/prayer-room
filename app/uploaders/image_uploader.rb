# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include Cloudinary::CarrierWave

  version :standard do
    process :resize_to_fill => [165, 150, :north]
  end

  version :thumbnail do
    process :resize_to_fit => [65, 65]
  end
  
end
