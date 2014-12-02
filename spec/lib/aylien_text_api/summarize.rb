describe "Summarize endpoint" do
  before do
    @url = "http://www.bbc.com/sport/0/football/25912393"
    @text = %q[Batman has always been my favourite superhero ever since the first time I heard about him because he his human with no powers, also he is much more questionable than any other superhero. The story of the film is about Batman, Lieutenant James Gordon, and new district attorney Harvey Dent beginning to succeed in rounding up the criminals that plague Gotham City. They are unexpectedly challenged when a mysterious criminal mastermind known as the Joker appears in Gotham. Batman's struggle against the Joker becomes deeply personal, forcing him to "confront everything he believes" and to improve his technology (which introduces the recreation of the Batcycle, known as the Batpod and the Batsuit was redesigned) to stop the madman's campaign of destruction. During the course of the film, a love triangle develops between Bruce Wayne, Dent and Rachel Dawes.  There are now six Batman films and I must say that The Dark Knight is the best out of all of them. The title is good because that is what Batman actually is. It has been 3 years for the adventure to continue from Batman Begins but that entire wait was worth it. Gotham city is very Gothic looking and is very haunting and visionary. The whole movie is charged with pulse-pounding suspense, ingenious special effects and riveting performances from a first-rate cast especially from Heath Ledger who gave an Oscar nomination performance for best supporting-actor. It is a shame that he can't see his terrific work on-screen. The cinematography is excellent which is made so dark & sinister that really did suit the mood for the film. Usually sequels don't turn out to be better than the original but The Dark Knight is one of those rare sequels that surpasses the original like The Godfather 2. I also really liked the poster where the building is on fire in a Bat symbol & Batman is standing in front of it. Christopher Nolan is a brilliant director and his film Memento is one of my most favourite films. He hasn't made 10 movies yet and 3 of them are already on the IMDb top 250. Overall The Dark Knight is the kind of movie that will make the audience cheer in the end instead of throwing fruit & vegetables on the screen.]
    @title = "Batman at his best and beyond"
  end

  it "shouldn't be nil with valid url" do
    VCR.use_cassette('summarize_with_valid_url') do
      result = @client.summarize(url: @url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with title and text" do
    VCR.use_cassette('summarize_with_title_and_text') do
      result = @client.summarize(title: @title, text: @text)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as valid url" do
    VCR.use_cassette('summarize_with_value_as_valid_url') do
      result = @client.summarize(@url)
      result.wont_be_nil
    end
  end

  it "shouldn't be nil with value as text and title" do
    VCR.use_cassette('summarize_with_value_as_text_and_title') do
      result = @client.summarize(@text, title: @title)
      result.wont_be_nil
    end
  end

  it "should be nil with value as text and without title" do
    VCR.use_cassette('summarize_with_value_as_text_and_without_title') do
      result = @client.summarize(@text)
      result.must_be_nil
    end
  end

  it "should be nil with invalid params" do
    VCR.use_cassette('summarize_with_invalid_params') do
      result = @client.summarize(wrong_param: @text)
      result.must_be_nil
    end
  end

  it "should be nil with unauthenticated client" do
    VCR.use_cassette('summarize_with_unauthenticated_client') do
      result = @unauthenticated_client.summarize(text: @text)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with unauthenticated client" do
    VCR.use_cassette('summarize_with_unauthenticated_client') do
      proc {
        @unauthenticated_client.summarize!(text: @text)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should be nil with invalid client" do
    VCR.use_cassette('summarize_with_invalid_client') do
      result = @invalid_client.summarize(url: @url)
      result.must_be_nil
    end
  end

  it "should raise Forbidden with invalid client" do
    VCR.use_cassette('summarize_with_invalid_client') do
      proc {
        @invalid_client.summarize!(url: @url)
      }.must_raise AylienTextApi::Error::Forbidden
    end
  end

  it "should raise BadRequest with value as text and without title" do
    VCR.use_cassette('summarize_with_value_as_text_and_without_title') do
      proc {
        @client.summarize!(@text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end

  it "should raise BadRequest with invalid params" do
    VCR.use_cassette('summarize_with_invalid_params') do
      proc {
        @client.summarize!(wrong_param: @text)
      }.must_raise AylienTextApi::Error::BadRequest
    end
  end
end
