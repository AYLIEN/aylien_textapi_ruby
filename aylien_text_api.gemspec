# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "aylien_text_api/version"

Gem::Specification.new do |s|
  s.name        = "aylien_text_api"
  s.version     = AylienTextApi::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Aylien Inc.", "Hamed Ramezanian"]
  s.license     = 'Apache-2.0'
  s.email       = ["support@aylien.com", "hamed.r.nik@gmail.com"]
  s.homepage    = "https://github.com/AYLIEN/aylien_textapi_ruby"
  s.summary     = %q{AYLIEN Text Analysis API is a package of Natural Language Processing and Machine Learning-powered tools for analyzing and extracting various kinds of information from text and images.}
  s.description = %q{AYLIEN Text Analysis API is a package of Natural Language Processing and Machine Learning-powered tools for analyzing and extracting various kinds of information from text and images.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = '>= 1.9'

  s.add_development_dependency 'rake', '~> 10.4'
  s.add_development_dependency 'minitest', '~> 5.4'
  s.add_development_dependency 'vcr', '~> 2.9'
  s.add_development_dependency 'webmock', '~> 1.20'
end
