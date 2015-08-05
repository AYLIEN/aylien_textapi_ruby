# encoding: utf-8

describe "Combined endpoint" do
  before do
    @url = "http://techcrunch.com/2014/10/20/the-super-slim-kindle-voyage-is-a-great-travel-companion/"
    @text = %q(CCTV footage shows the moment a suicide car bomber detonates
      a device in Beirut on Tuesday. The incident took place in an area
      of support for Hezbollah and left four people dead with many more wounded.
      A group calling itself the al-Nusra Front in Lebanon has claimed
      responsibility for the attack saying it was in retaliation for
      Hezbollah's military support of president Bashar al-Assad's forces in Syria)
    @endpoints = ['extract', 'concepts', 'entities', 'summarize', 
      'classify', 'hashtags', 'language']
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('combined_with_valid_url') do
      result = @client.combined(url: @url, endpoint: @endpoints)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('combined_with_text') do
      result = @client.combined(text: @text, endpoint: @endpoints)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('combined_with_value_as_valid_url') do
      result = @client.combined(@url, endpoint: @endpoints)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as value" do
    VCR.use_cassette('combined_with_value_as_text') do
      result = @client.combined(@text, endpoint: @endpoints)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('combined_with_invalid_params') do
      result = @client.combined(wrong_param: @text, endpoint: @endpoints)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('combined_with_unauthenticated_client') do
      result = @unauthenticated_client.combined(text: @text, endpoint: @endpoints)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('combined_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.combined!(text: @text, endpoint: @endpoints)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('combined_with_invalid_client') do
      result = @invalid_client.combined(text: @text, endpoint: @endpoints)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('combined_with_invalid_client') do
      proc {
        @invalid_client.combined!(text: @text, endpoint: @endpoints)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('combined_with_invalid_params') do
      proc {
        @client.combined!(wrong_param: @text, endpoint: @endpoints)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
