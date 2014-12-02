require_relative '../lib/aylien_text_api'

#dependencies
require 'minitest/autorun'
require 'webmock/minitest'
require 'vcr'

CONFIG = YAML.load(File.read(File.expand_path('../../config/app_config.yml', __FILE__)))

#VCR config
VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/aylien_text_api/client'
  c.hook_into :webmock
  c.filter_sensitive_data('<PASSWORD>') {CONFIG["text_api"]["correct_keys"]["app_id"]}
  c.filter_sensitive_data('<PASSWORD>') {CONFIG["text_api"]["correct_keys"]["app_key"]}
end
