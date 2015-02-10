# encoding: utf-8

describe "Microformats endpoint" do
  before do
    @url = "http://codepen.io/anon/pen/ZYaKbz.html"
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('microformats_with_valid_url') do
      result = @client.microformats(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('microformats_with_value_as_valid_url') do
      result = @client.microformats(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('microformats_with_invalid_params') do
      result = @client.microformats(wrong_param: @url)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('microformats_with_unauthenticated_client') do
      result = @unauthenticated_client.microformats(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('microformats_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.microformats!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('microformats_with_invalid_client') do
      result = @invalid_client.microformats(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('microformats_with_invalid_client') do
      proc {
        @invalid_client.microformats!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('microformats_with_invalid_params') do
      proc {
        @client.microformats!(wrong_param: @url)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
