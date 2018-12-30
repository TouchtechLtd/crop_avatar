module CropableAvatar
    extend ActiveSupport::Concern

    included do
        has_one_attached :avatar
    end

    def cropped_avatar_variant(**kwargs)
        return gravatar_url unless avatar.attached?
        if !avatar_crop.blank?
            avatar.variant(crop: avatar_crop, **kwargs)
        else
            avatar.variant(**kwargs)
        end
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