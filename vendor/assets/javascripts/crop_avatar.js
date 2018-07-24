//= require exif
//= require jquery.cropit

// Avatar upload
function cropAvatarSetup() {
  var $avatar = $('#avatar-image'),
    $input = $avatar.find('.cropit-image-input'),
    $preview = $avatar.find('.cropit-preview'),
    $prompt = $avatar.find('.prompt')

  $preview.click(function() {
    if($avatar.hasClass('cropit-disabled')) {
      $input.click()
    }
  })
  $prompt.click(function() {
    $input.click()
  })

  $input.on('change', function() {
    if(this.files.length > 0) {
      $avatar.cropit('reenable');
      $prompt.attr('placeholder', 'Click to change photo')
    } else {
      $avatar.cropit('imageSrc', $avatar.find('.cropit-preview').data('url'));
      $avatar.cropit('disable');
      $prompt.attr('placeholder', 'Click to upload photo')
    }
  })
  $avatar.cropit({
    allowDragNDrop: false,
    onImageError: console.log,
    smallImage: 'stretch',
    initialZoom: 'min',
    imageBackground: true,
    imageBackgroundBorderWidth: 15,
    imageState: {
      src: $avatar.find('.cropit-preview').data('url')
    }
  }).cropit('disable')

  $avatar.closest('form').on('submit', function() {
    var size = $avatar.cropit('imageSize'),
      crop = $avatar.cropit('offset'),
      zoom = $avatar.cropit('zoom'),
      portrait = size.height > size.width,
      dimen = portrait ? size.width : size.height
    $('#avatar_crop').val(dimen + 'x' + dimen + '+' + (crop.x * -1 / zoom) + '+' + (crop.y * -1 / zoom));
  })
};