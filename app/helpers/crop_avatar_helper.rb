module CropAvatarHelper

  def crop_avatar_tag(object, method, options = {})
    avatar = object.nil? ? 0 : object.send(method)

    content_tag :div, id: 'avatar-image' do
      ['x', 'y', 'w', 'h'].each do |attribute|
        attr = "#{method}_crop_#{attribute}"
        concat hidden_field_tag field_name(object, attr, options[:index]), 0, id: attr
      end
      concat "<div class='cropit-preview' data-url='#{avatar.url(:medium)}'></div>".html_safe
      concat file_field_tag field_name(object, method, options[:index]), class: 'cropit-image-input', accept: 'image/*'
      concat text_field_tag 'prompt', nil, class: 'prompt', placeholder: 'Click to upload photo', readonly: true
      concat "<script type='text/javascript'>cropAvatarSetup()</script>".html_safe
    end
  end

  def field_name(object, method, index=nil)
    output = index ? "[#{index}]" : ''
    return object.class.to_s.parameterize + output + "[#{method}]"
  end
end
