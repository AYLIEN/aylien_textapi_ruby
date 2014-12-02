# encoding: utf-8

describe "Hashtags endpoint" do
  before do
    @url = "http://www.bbc.com/sport/0/football/25912393"
    @text = %q(The Google Cast SDK is simple to integrate because there’s no
      need to write a new app. Just incorporate the SDK into your existing
      mobile and web apps to bring your content to the TV. You are in
      control of how and when you develop and publish your cast-ready
      apps through the Google Cast developer console.
      The SDK is available on Android and iOS as well as on Chrome
      through the Google Cast browser extension.)
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('hashtags_with_valid_url') do
      result = @client.hashtags(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('hashtags_with_text') do
      result = @client.hashtags(text: @text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as text" do
    VCR.use_cassette('hashtags_with_value_as_text') do
      result = @client.hashtags(@text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('hashtags_with_value_as_valid_url') do
      result = @client.hashtags(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('hashtags_with_unauthenticated_client') do
      result = @unauthenticated_client.hashtags(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('hashtags_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.hashtags!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('hashtags_with_invalid_client') do
      result = @invalid_client.hashtags(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('hashtags_with_invalid_client') do
      proc {
        @invalid_client.hashtags!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('hashtags_with_invalid_params') do
      result = @client.hashtags(wrong_param: @text)
      result.must_be_nil
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('hashtags_with_invalid_params') do
      proc {
        @client.hashtags!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
