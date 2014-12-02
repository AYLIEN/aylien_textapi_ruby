describe "Related endpoint" do
  before do
    @phrase = "android"
    @url = "http://www.bbc.com/sport/0/football/25912393"
  end

  it "shouldn't be nil with phrase" do
    VCR.use_cassette('related_with_phrase') do
      result = @client.related(phrase: @phrase)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as phrase" do
    VCR.use_cassette('related_with_value_as_phrase') do
      result = @client.related(@phrase)
      result.wont_be_nil
    end
  end

  it "should be nil with value as valid url" do
    VCR.use_cassette('related_with_value_as_valid_url') do
      result = @client.related(@url)
      result.must_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('related_with_invalid_params') do
      result = @client.related(wrong_param: @phrase)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('related_with_unauthenticated_client') do
      result = @unauthenticated_client.related(phrase: @phrase)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('related_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.related!(phrase: @phrase)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('related_with_invalid_client') do
      result = @invalid_client.related(phrase: @phrase)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('related_with_invalid_client') do
      proc {
        @invalid_client.related!(phrase: @phrase)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with value as valid url" do
    VCR.use_cassette('related_with_value_as_valid_url') do
      proc {
        @client.related!(@url)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('related_with_invalid_params') do
      proc {
        @client.related!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
