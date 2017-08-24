require 'paperclip_processors/avatar_cropper'

module CropableAvatar
    extend ActiveSupport::Concern

    included do
        has_attached_file :avatar,
            styles: { medium: "300x300>", thumb: "100x100>" },
            default_url: :gravatar_url,
            processors: [:avatar_cropper]
        validates_attachment_content_type :avatar, content_type: ['image/jpeg', 'image/jpeg', 'image/png']

        attr_accessor :avatar_crop_x, :avatar_crop_y, :avatar_crop_w, :avatar_crop_h
    end

    def cropping_avatar?
        !avatar_crop_x.blank? && !avatar_crop_y.blank? && !avatar_crop_w.blank? && !avatar_crop_h.blank?
    end

    private
    def gravatar_url
        hash = Digest::MD5.hexdigest(try(:email) || name&.parameterize || 'Unknown')
        if CropAvatar.gravatar_default_missing_image_enabled
            fallback_url =  "mm"
        else
            fallback_url = "http://#{Rails.application.routes.default_url_options[:host]}/#{CropAvatar.default_missing_image_path}"
        end
        uri = "https://secure.gravatar.com/avatar/#{hash}?s=200&d=#{fallback_url}"
        uri.class.class_eval { def escape; self; end }
        uri
    end

end