# encoding: utf-8
class ProfileImgUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [275, 275]

  version :thumbnail do
    process resize_to_fill: [150, 150]
  end

  def extension_white_list
    %w(jpg jpeg png)
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("image_not_found_fallbacks/" + [version_name, "profile_default.png"].compact.join('_'))
  end

end