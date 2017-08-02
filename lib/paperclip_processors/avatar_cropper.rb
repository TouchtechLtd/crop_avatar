require 'paperclip'

module Paperclip
  class AvatarCropper < Thumbnail
    def transformation_command
      if crop_command
        ['-auto-orient', crop_command] + super
      else
        super
      end
    end

    def crop_command
      name = @attachment.name.to_s
      target = @attachment.instance
      if target.send("cropping_#{name}?")
        crops = [target.send("#{name}_crop_w"), target.send("#{name}_crop_h"), target.send("#{name}_crop_x"), target.send("#{name}_crop_y")].map(&:to_i)
        " -crop #{crops[0]}x#{crops[1]}+#{crops[2]}+#{crops[3]}"
      end
    end
  end
end