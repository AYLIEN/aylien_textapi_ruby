describe "Concepts endpoint" do
  before do
    @url = "http://www.bbc.co.uk/news/business-25821345"
    @text = %q(Barack Hussein Obama II is the 44th and current
      President of the United States, and the first
      African American to hold the office.)
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('concepts_with_valid_url') do
      result = @client.concepts(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('concepts_with_text') do
      result = @client.concepts(text: @text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('concepts_with_value_as_valid_url') do
      result = @client.concepts(@url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as text" do
    VCR.use_cassette('concepts_with_value_as_text') do
      result = @client.concepts(@text)
      result.wont_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('concepts_with_unauthenticated_client') do
      result = @unauthenticated_client.concepts(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('concepts_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.concepts!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('concepts_with_invalid_client') do
      result = @invalid_client.concepts(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('concepts_with_invalid_client') do
      proc {
        @invalid_client.concepts!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('concepts_with_invalid_params') do
      result = @client.concepts(wrong_param: @text)
      result.must_be_nil
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('concepts_with_invalid_params') do
      proc {
        @client.concepts!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
