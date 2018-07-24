# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "crop_avatar/version"

Gem::Specification.new do |spec|
  spec.name          = "crop_avatar"
  spec.version       = CropAvatar::VERSION
  spec.authors       = ["Jesse Hills"]
  spec.email         = ["jesse@springload.co.nz"]

  spec.summary       = %q{Simple helpers to show form fields for uploading avatar and cropping it to specified size}
  spec.homepage      = "https://github.com/Touchtechltd/crop_avatar.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activestorage', '>= 5.2.0'

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
end
