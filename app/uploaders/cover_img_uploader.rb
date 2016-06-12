# encoding: utf-8
class CoverImgUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  process resize_to_fill: [665, 375]

  def extension_white_list
    %w(jpg jpeg png)
  end
end