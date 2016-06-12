# encoding: utf-8
class CoverImgUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [669, 200]

  version :preview do
    process resize_to_fill: [525, 150]
  end

  version :thumbnail do
    process resize_to_fill: [150, 150]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("image_not_found_fallbacks/" + [version_name, "default.png"].compact.join('_'))
  end

end