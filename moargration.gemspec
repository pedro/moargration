# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |gem|
  gem.name          = "moargration"
  gem.version       = "0.0.2"
  gem.authors       = ["Pedro Belo"]
  gem.email         = ["pedro@heroku.com"]
  gem.description   = %q{Helping you migrate, MOAR.}
  gem.summary       = %q{To assist app developers with tricky database migrations}
  gem.homepage      = "https://github.com/pedro/moargration"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
