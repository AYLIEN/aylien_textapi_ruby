About
=====

This is the Ruby client library for AYLIEN's APIs. If you haven't already done so, you will need to [sign up](https://developer.aylien.com/signup).


Installation
============
    gem install aylien_text_api

See the [Developers Guide](https://developer.aylien.com/docs) for additional documentation.

Configuration
=============
Aylien Text API needs app_id and app_key which you can get it from [Text API website](https://developer.aylien.com/signup).

You can pass configuration options as a block to AylienTextApi::Client.new.

    require 'aylien_text_api'

    client = AylienTextApi::Client.new do |config|
      config.app_id        =    "YOUR_APP_ID"
      config.app_key       =    "YOUR_APP_KEY"
    end
or pass them as parameters to AylienTextApi::Client class.

    require 'aylien_text_api'

    client = AylienTextApi::Client.new(app_id: "YOUR APP ID", app_key: "YOUR APP KEY")

Examples
=====
After configuring a client, you can do the following things:

    client.extract url: "http://techcrunch.com/2014/02/27/aylien-launches-text-analysis-api-to-help-developers-extract-meaning-from-documents/"
    # => {
      :title=>"Aylien Launches Text-Analysis API To Help Developers...",
      :article=>"Working with text is often a messy business for...",
      :image=>"", :author=>"Frederic Lardinois", :videos=>[],
      :feeds=>["http://techcrunch.com/2014/02/27/aylien-...
      }
If any errors happen during the call, nil will be returned. If destructive methods are used, an exception corresponding to the error will be returned.

    client.classify! url: "http://www.bbc.com/sport/0/football/25912393"
    # => {:text=>"Lionel Messi: Forward is not for sale, says...,
     :language=>"en",
     :categories=>[{:label=>"sport - soccer", :code=>"15054000", :confidence=>1.0}]
     }

Third Party Libraries and Dependencies
======================================
For development you will also need the following libraries:

* rake
* minitest
* vcr
* webmock
