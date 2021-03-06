# coding: utf-8
require 'date'
require_relative 'lib/jekyll-webp-resize/version'

warn "[DEPRECATION] This gem has been renamed to jekyll-imagemagick and will no longer be supported. " \
     "Please switch to jekyll-imagemagick as soon as possible."

Gem::Specification.new do |spec|
  spec.name          = "jekyll-webp-resize"
  spec.version       = Jekyll::Webp::VERSION
  spec.platform      = Gem::Platform::RUBY
  spec.date          = DateTime.now.strftime('%Y-%m-%d')
  spec.authors       = ["Sverrir Sigmundarson", "Emilio Del Tessandoro"]
  spec.email         = ["jekyll@sverrirs.com", "emilio.deltessa@gmail.com"]
  spec.homepage      = "https://github.com/emmmile/jekyll-webp"
  spec.license       = "MIT"

  spec.summary       = %q{WebP image generator for Jekyll 3 websites}
  spec.description   = %q{WebP Image Generator for Jekyll 3 Sites that automatically generate WebP images for all images on your static site and serves them when possible.}

  spec.files         = Dir['CODE_OF_CONDUCT.md', 'README.md', 'LICENSE', 'Rakefile', '*.gemspec', 'Gemfile', 'lib/**/*', 'spec/**/*', 'bin/**/*']
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^spec/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "jekyll", "~> 3.0"
  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake", "~> 1.5"
  spec.add_development_dependency "minitest", '~> 5.4', '>= 5.4.3'
  spec.add_runtime_dependency "fastimage", '~> 2.1'
  # spec.add_runtime_dependency "rmagick", "~> 2.16"
  spec.post_install_message = <<-MESSAGE
    !    The jekyll-webp-resize gem has been deprecated and has been replaced by jekyll-imagemagik.
    !    See: https://rubygems.org/gems/jekyll-imagemagick
    !    And: https://gitlab.com/emmmile/jekyll-imagemagick
    MESSAGE
end
