describe "RateLimits header parameter" do
  before do
    @text = %q(Hello there! How's it going?)
  end
  
  it "shouldn't be nil" do
    VCR.use_cassette('rate_limits') do
      result = @client.rate_limits
      result.wont_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('rate_limits_with_unauthenticated_client') do
      result = @unauthenticated_client.rate_limits
      result[:limit].must_be_nil
      result[:remaining].must_be_nil
      result[:reset].must_be_nil
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('rate_limits_with_invalid_client') do
      result = @invalid_client.rate_limits
      result[:limit].must_be_nil
      result[:remaining].must_be_nil
      result[:reset].must_be_nil
    end
  end
end
