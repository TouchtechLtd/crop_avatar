module CropAvatarHelper

  def crop_avatar_tag(object, method, options = {})
    avatar = object.nil? ? 0 : object.send(method)

    content_tag :div, id: 'avatar-image' do
      attr = "#{method}_crop"
      concat hidden_field_tag field_name(object, attr, options[:index]), 0, id: attr
      concat "<div class='cropit-preview' data-url='#{object.cropped_avatar_variant(resize: '300x300')}'></div>".html_safe
      concat file_field_tag field_name(object, method, options[:index]), class: 'avatar-upload cropit-image-input', accept: 'image/*'
      concat text_field_tag 'file-path', nil, class: 'file-path', placeholder: "<%= t('.click_to_upload') %>", readonly: true
      concat "<script type='text/javascript'>cropAvatarSetup()</script>".html_safe
    end
  end

  def field_name(object, method, index=nil)
    output = index ? "[#{index}]" : ''
    return object.class.to_s.parameterize + output + "[#{method}]"
  end
end
