require_relative '../../spec_helper'

describe AylienTextApi::Client do
  before do
    @client = AylienTextApi::Client.new(
      app_id: CONFIG["text_api"]["correct_keys"]["app_id"],
      app_key: CONFIG["text_api"]["correct_keys"]["app_key"])
    @unauthenticated_client = AylienTextApi::Client.new(
      app_id: CONFIG["text_api"]["incorrect_keys"]["app_id"],
      app_key: CONFIG["text_api"]["incorrect_keys"]["app_key"])
    @invalid_client = AylienTextApi::Client.new(incorrect_param_app_id: CONFIG["text_api"]["app_id"],
      incorrect_param_app_key: CONFIG["text_api"]["correct_keys"]["app_key"])
  end
  require_relative './classify'
  require_relative './concepts'
  require_relative './entities'
  require_relative './extract'
  require_relative './hashtags'
  require_relative './language'
  require_relative './related'
  require_relative './sentiment'
  require_relative './summarize'
end
