describe "image_tags endpoint" do
  before do
    @url = "http://aylien.com/images/michaelo.png"
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('image_tags_with_valid_url') do
      result = @client.image_tags(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('image_tags_with_value_as_valid_url') do
      result = @client.image_tags(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('image_tags_with_invalid_params') do
      result = @client.image_tags(text: @text)
      result.must_be_nil
    end
  end

  it "should be nil with value as text" do
    VCR.use_cassette('image_tags_with_value_as_text') do
      result = @client.image_tags(@text)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('image_tags_with_unauthenticated_client') do
      result = @unauthenticated_client.image_tags(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('image_tags_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.image_tags!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('image_tags_with_invalid_client') do
      result = @invalid_client.image_tags(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('image_tags_with_invalid_client') do
      proc {
        @invalid_client.image_tags!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with value as text" do
    VCR.use_cassette('image_tags_with_value_as_text') do
      proc {
        @client.image_tags!(@text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('image_tags_with_invalid_params') do
      proc {
        @client.image_tags!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
