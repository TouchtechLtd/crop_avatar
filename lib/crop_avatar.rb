require "crop_avatar/version"

module CropAvatar
  class Engine < ::Rails::Engine; end

  mattr_accessor :gravatar_default_missing_image_enabled
  @@use_default_missing_image = true

  mattr_accessor :default_missing_image_path
  @@default_missing_image_path = "images/default_logo.jpg"

  def self.setup
    yield self
  end

end
