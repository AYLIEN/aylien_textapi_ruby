# encoding: utf-8

describe "ABSA endpoint" do
  before do
    @url = "http://techcrunch.com/2014/10/20/the-super-slim-kindle-voyage-is-a-great-travel-companion/"
    @text = %q(We visited here during our recent trip to Sydney and 
      overall we were very impressed. We decided to make a reservation online, 
      which was quick and easy with instant confirmation. 
      It was nice to be able to view the table layout and select our own online. 
      The location is spectacular with stunning views of the harbour 
      and Opera House. It truly was amazing. 
      Despite this, however, the restaurant was  only about 25% 
      full and so the atmosphere was a bit flat. Perhaps this was to our 
      benefit as we received top class service from our waiter, 
      Brandon, who was not only friendly and funny but extremely 
      knowledgeable when it came to food and wine pairings. 
      Speaking of wine, the list was extensive - we loved it - 
      and it took us what seemed like an hour to eventually 
      decide on a local Shiraz. Now on to the most important 
      aspect, the food. Our seafood starters were delicious, 
      as were out fillet steak mains. 
      The one and only real disappointment was the dessert which was served 
      with no real imagination and looked like it had been purchased 
      yesterday at the local grocery store. 
      All in all, my favourite Sydney restaurant so far. 
      So many positives and really good value too. Highly recommend!)
    @domain = "restaurants"
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('absa_with_valid_url') do
      result = @client.aspect_based_sentiment(url: @url, domain: @domain)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('absa_with_text') do
      result = @client.aspect_based_sentiment(text: @text, domain: @domain)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('absa_with_value_as_valid_url') do
      result = @client.aspect_based_sentiment(@url, domain: @domain)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as value" do
    VCR.use_cassette('absa_with_value_as_text') do
      result = @client.aspect_based_sentiment(@text, domain: @domain)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('absa_with_invalid_params') do
      result = @client.aspect_based_sentiment(wrong_param: @text, domain: @domain)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('absa_with_unauthenticated_client') do
      result = @unauthenticated_client.aspect_based_sentiment(text: @text, domain: @domain)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('absa_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.aspect_based_sentiment!(text: @text, domain: @domain)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('absa_with_invalid_client') do
      result = @invalid_client.aspect_based_sentiment(text: @text, domain: @domain)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('absa_with_invalid_client') do
      proc {
        @invalid_client.aspect_based_sentiment!(text: @text, domain: @domain)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('absa_with_invalid_params') do
      proc {
        @client.aspect_based_sentiment!(wrong_param: @text, domain: @domain)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
