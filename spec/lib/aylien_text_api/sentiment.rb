describe "Sentiment endpoint" do
  before do
    @url = "http://www.bbc.com/sport/0/football/25912393"
    @text = %q(I really enjoyed using the Canon Ixus in Madrid.
      The Panasonic Lumix is a poor camera, but the Canon Ixus is really sleek.
      The Canon Ixus is much better than the Panasonic Lumix.
      All I want to do with a camera is point it and then just press the button.
      The Canon Ixus is perfect for that. You will soon get great photos
      with very little effort. I had previously returned a Panasonic Lumix
      because the pictures were not of the quality I expected.
      Spending the money on the Canon was a smart move.
      I would recommend the Ixus to anyone without hesitation.
      Two small issues to be pointed out: firstly, the battery
      life is not fantastic. Also, the zoom is not very powerful.
      If your subject is far away, you should not expect good results.
      Review made by John Irving from Florida.)
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('sentiment_with_valid_url') do
      result = @client.sentiment(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('sentiment_with_text') do
      result = @client.sentiment(text: @text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as text" do
    VCR.use_cassette('sentiment_with_value_as_text') do
      result = @client.sentiment(@text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('sentiment_with_value_as_valid_url') do
      result = @client.sentiment(@url)
      result.wont_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('sentiment_with_unauthenticated_client') do
      result = @unauthenticated_client.sentiment(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('sentiment_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.sentiment!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('sentiment_with_invalid_client') do
      result = @invalid_client.sentiment(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('sentiment_with_invalid_client') do
      proc {
        @invalid_client.sentiment!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('sentiment_with_invalid_params') do
      result = @client.sentiment(wrong_param: @text)
      result.must_be_nil
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('sentiment_with_invalid_params') do
      proc {
        @client.sentiment!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
