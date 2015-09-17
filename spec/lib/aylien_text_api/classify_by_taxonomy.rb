# encoding: utf-8

describe "Classify by taxonomy endpoint" do
  before do
    @url = "http://techcrunch.com/2014/10/20/the-super-slim-kindle-voyage-is-a-great-travel-companion/"
    @text = %q(CCTV footage shows the moment a suicide car bomber detonates
      a device in Beirut on Tuesday. The incident took place in an area
      of support for Hezbollah and left four people dead with many more wounded.
      A group calling itself the al-Nusra Front in Lebanon has claimed
      responsibility for the attack saying it was in retaliation for
      Hezbollah's military support of president Bashar al-Assad's forces in Syria)
    @taxonomy = "iab-qag"
    @invalid_taxonomy = "random_string"
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('classify_by_taxonomy_with_valid_url') do
      result = @client.classify_by_taxonomy(url: @url, taxonomy: @taxonomy)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with text" do
    VCR.use_cassette('classify_by_taxonomy_with_text') do
      result = @client.classify_by_taxonomy(text: @text, taxonomy: @taxonomy)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('classify_by_taxonomy_with_value_as_valid_url') do
      result = @client.classify_by_taxonomy(@url, taxonomy: @taxonomy)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as value" do
    VCR.use_cassette('classify_by_taxonomy_with_value_as_text') do
      result = @client.classify_by_taxonomy(@text, taxonomy: @taxonomy)
      result.wont_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('classify_with_invalid_params') do
      result = @client.classify_by_taxonomy(wrong_param: @text, taxonomy: @taxonomy)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('classify_by_taxonomy_with_unauthenticated_client') do
      result = @unauthenticated_client
        .classify_by_taxonomy(text: @text, taxonomy: @taxonomy)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('classify_by_taxonomy_with_unauthenticated_client') do
      proc {
        @unauthenticated_client
          .classify_by_taxonomy!(text: @text, taxonomy: @taxonomy)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('classify_by_taxonomy_with_invalid_client') do
      result = @invalid_client
        .classify_by_taxonomy(text: @text, taxonomy: @taxonomy)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('classify_by_taxonomy_with_invalid_client') do
      proc {
        @invalid_client.classify_by_taxonomy!(text: @text, taxonomy: @taxonomy)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('classify_by_taxonomy_with_invalid_params') do
      proc {
        @client.classify_by_taxonomy!(wrong_param: @text, taxonomy: @taxonomy)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
  
  it "should raise InvalidInput with empty taxonomy" do
    VCR.use_cassette('classify_by_taxonomy_with_empty_taxonomy') do
      proc {
        @client.classify_by_taxonomy(text: @text)
      }.must_raise AylienTextApi::Error::InvalidInput
      
      proc {
        @client.classify_by_taxonomy!(text: @text)
      }.must_raise AylienTextApi::Error::InvalidInput
      
      proc {
        @client.classify_by_taxonomy!(text: @text, taxonomy: '')
      }.must_raise AylienTextApi::Error::InvalidInput
    end
  end
  
  it "should be nil with invalid taxonomy" do
    VCR.use_cassette('classify_by_taxonomy_with_invalid_taxonomy') do
      result = @client
        .classify_by_taxonomy(text: @text, taxonomy: @invalid_taxonomy)
      result.must_be_nil
    end
  end
  
  it "should raise BadRequest with invalid taxonomy" do
    VCR.use_cassette('classify_by_taxonomy_with_invalid_taxonomy') do
      proc {
        @client
          .classify_by_taxonomy!(text: @text, taxonomy: @invalid_taxonomy)
      }.must_raise AylienTextApi::Error::NotFound
    end
  end
end
