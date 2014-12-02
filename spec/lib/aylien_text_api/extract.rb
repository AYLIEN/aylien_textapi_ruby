describe "Extract endpoint" do
  before do
    @url = "http://www.bbc.com/sport/0/football/30180206"
    @text = %q(The oil-rich billionaires of the Gulf have planted
                a flag at the heart of the sporting landscape in recent years.)
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('extract_with_valid_url') do
      result = @client.extract(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('extract_with_value_as_valid_url') do
      result = @client.extract(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('extract_with_invalid_params') do
      result = @client.extract(text: @text)
      result.must_be_nil
    end
  end

  it "should be nil with value as text" do
    VCR.use_cassette('extract_with_value_as_text') do
      result = @client.extract(@text)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('extract_with_unauthenticated_client') do
      result = @unauthenticated_client.extract(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('extract_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.extract!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('extract_with_invalid_client') do
      result = @invalid_client.extract(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('extract_with_invalid_client') do
      proc {
        @invalid_client.extract!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with value as text" do
    VCR.use_cassette('extract_with_value_as_text') do
      proc {
        @client.extract!(@text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('extract_with_invalid_params') do
      proc {
        @client.extract!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
