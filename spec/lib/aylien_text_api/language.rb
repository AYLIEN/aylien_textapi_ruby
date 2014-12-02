describe "Language endpoint" do
  before do
    @url = "http://www.bbc.com/sport/0/football/25912393"
    @text = %q(Hello there! How's it going?)
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('language_with_valid_url') do
      result = @client.language(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with valid text" do
    VCR.use_cassette('language_with_valid_text') do
      result = @client.language(text: @text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as text" do
    VCR.use_cassette('language_with_value_as_text') do
      result = @client.language(@text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('language_with_value_as_valid_url') do
      result = @client.language(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('language_with_unauthenticated_client') do
      result = @unauthenticated_client.language(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('language_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.language!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('language_with_invalid_client') do
      result = @invalid_client.language(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('language_with_invalid_client') do
      proc {
        @invalid_client.language!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('language_with_invalid_params') do
      result = @client.language(wrong_param: @text)
      result.must_be_nil
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('language_with_invalid_params') do
      proc {
        @client.language!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
