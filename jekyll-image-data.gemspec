# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll-image-data/version'

Gem::Specification.new do |spec|
  spec.name     = "jekyll-image-data"
  spec.version  = JekyllImageData::VERSION
  spec.authors  = ["Jose Miguel Venegas Mendoza"]
  spec.email    = ["jvenegasmendoza@gmail.com"]
  spec.homepage = "https://github.com/rukbotto/jekyll-image-data"
  spec.license  = "MIT"

  spec.summary     = "Image data for Jekyll posts and pages."
  spec.description = <<-DESCRIPTION
    Image data for Jekyll posts and pages. Crawls markdown files in search of
    image data ("src" and "alt" attributes) and makes it available as a
    post/page metadata attribute.
  DESCRIPTION

  spec.files =
    `git ls-files -z`.split("\x0").reject do |f|
      f.match(%r{^(test|spec|features)/})
    end
  spec.require_paths = ["lib"]

  spec.add_dependency "jekyll", "~> 3.4.0"

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
