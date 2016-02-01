# Copyright 2015 Aylien, Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

module AylienTextApi
  # The Client class is the main class for calling Text API endpoints
  class Client
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    # Creates a Client object.
    # @param [Hash] options Configuration params
    # @option options [String] :app_id The APP_ID
    # @option options [String] :app_key The APP_KEY
    # @option options [String] :base_uri ('https://api.aylien.com/api/v1/')
    #   An URL that points to the Aylien Text API
    # @option options [Symbol] :method (:post) Request method.
    # @option options [String] :user_agent Request user-agent
    def initialize(options={})
      merged_options = AylienTextApi.options.merge(options)

      Configuration::VALID_CONFIG_KEYS.each do |key|
        send("#{key}=", merged_options[key])
      end
    end

    # Extracts the main body of article, including embedded media such as
    # images & videos from a URL and removes all the surrounding clutter.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The extract endpoint options
    # @option params [String] :url The URL
    # @option params [Boolean] :best_image (false)
    #   Whether extract the best image of the article
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/extract for more information
    #   on the data returned.
    #
    def extract(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:extract])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like extract, but calls request! so an exception is raised 
    # if the request fails.
    #
    def extract!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:extract])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end

    # Classifies a piece of text according to the specified taxonomy.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The classify endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/classify_by_taxonomy for more information
    #   on the data returned.
    #
    def classify_by_taxonomy(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:classify_by_taxonomy])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like classify_by_taxonomy, but calls request! so an exception is raised 
    # if the request fails.
    #
    def classify_by_taxonomy!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:classify_by_taxonomy])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Classifies a piece of text according to IPTC NewsCode standard.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The classify endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/classify for more information
    #   on the data returned.
    #
    def classify(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:classify])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like classify, but calls request! so an exception is raised 
    # if the request fails.
    #
    def classify!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:classify])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end

    # Extracts named entities mentioned in a document, disambiguates
    # and cross-links them to DBPedia and Linked Data entities, along with
    # their semantic types (including DBPedia and schema.org).
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The concepts endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/concepts for more information
    #   on the data returned.
    #
    def concepts(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:concepts])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like concepts, but calls request! so an exception is raised 
    # if the request fails.
    #
    def concepts!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:concepts])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end

    # Suggests hashtags describing the document.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The hashtags endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/hashtags for more information
    #   on the data returned.
    #
    def hashtags(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:hashtags])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like hashtags, but calls request! so an exception is raised 
    # if the request fails.
    #
    def hashtags!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:hashtags])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end

    # Extracts named entities (people, organizations and locations) and
    # values (URLs, emails, telephone numbers, currency amounts and percentages)
    # mentioned in a body of text.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The entities endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/entities for more information
    #   on the data returned.
    #
    def entities(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:entities])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like entities, but calls request! so an exception is raised 
    # if the request fails.
    #
    def entities!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:entities])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Detects the main language a document is written in and returns it
    # in ISO 639-1 format.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The language endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/language for more information
    #   on the data returned.
    #
    def language(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:language])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like language, but calls request! so an exception is raised 
    # if the request fails.
    #
    def language!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:language])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Detects sentiment of a document in terms of
    # polarity ("positive" or "negative") and
    # subjectivity ("subjective" or "objective").
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The sentiment endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [String] :mode ('tweet') Analyze mode.
    #   Valid options are tweet, and document.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/sentiment for more information
    #   on the data returned.
    #
    def sentiment(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:sentiment])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like sentiment, but calls request! so an exception is raised 
    # if the request fails.
    #
    def sentiment!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:sentiment])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    # Summarizes an article into a few key sentences.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The summarize endpoint options
    # @option params [String] :mode ('default') Analyze mode.
    #   Valid options are default and short.
    #   short mode produces shorter sentences.
    # @option params [String] :url The URL
    # @option params [String] :title Title
    # @option params [String] :text Text
    # @option params [Integer] :sentences_number (5) Number of sentences
    #   to be returned. Only in default mode (not applicable to short mode).
    #   Also has precedence over sentences_percentage.
    # @option params [Integer] :sentences_percentage Percentage of sentences
    #   to be returned. Only in default mode (not applicable to short mode).
    #   Possible range is 1-100.
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/summarize for more information
    #   on the data returned.
    #
    def summarize(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:summarize])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like summarize, but calls request! so an exception is raised 
    # if the request fails.
    #
    def summarize!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:summarize])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Returns phrases related to the provided unigram, or bigram.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The related endpoint options
    # @option params [String] :phrase Phrase
    # @option params [Integer] :count (20) Number of phrases to return.
    #   Max is 100.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/related for more information
    #   on the data returned.
    #
    def related(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:related])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like related, but calls request! so an exception is raised 
    # if the request fails.
    #
    def related!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:related])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Return Microformats.
    #
    # @param [String] value (nil) URL
    # @param [Hash] params The microformats endpoint options
    # @option params [String] :url The URL
    # @option params [String] :language ('en') Language of text.
    #   Valid options are en, de, fr, es, it, pt, and auto.
    #   If set to auto, it'll try to detect the language.
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/microformats for more information
    #   on the data returned.
    #
    def microformats(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:microformats])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like microformats, but calls request! so an exception is raised 
    # if the request fails.
    #
    def microformats!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:microformats])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Return Unsupervised Classify.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The Unsupervised Classify endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [Array<String>] :class Array of classes
    # @option params [Integer] :number_of_concepts Number of intermediary 
    #   common topics to consider when calculating semantic similarity
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/classify-unsupervised for more information
    #   on the data returned.
    #
    def unsupervised_classify(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:unsupervised_classify])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like unsupervised_classify, but calls request! so an exception is raised 
    # if the request fails.
    #
    def unsupervised_classify!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:unsupervised_classify])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Runs multiple analysis operations in one API call.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The Combined endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    # @option params [Array<String>] :endpoint Array of endpoints
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/combined for more information
    #   on the data returned.
    #
    def combined(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:combined])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like combined, but calls request! so an exception is raised 
    # if the request fails.
    #
    def combined!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:combined])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Assigns relevant tags to an image.
    #
    # @param [String] value (nil) URL
    # @option params [String] :url The URL
    #
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/image-tags for more information
    #   on the data returned.
    #
    def image_tags(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:image_tags])
      @connection = Connection.new(endpoint, params, config)
      @connection.request
    end
    
    # Like image_tags, but calls request! so an exception is raised 
    # if the request fails.
    #
    def image_tags!(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, 
        Configuration::ENDPOINTS[:image_tags])
      @connection = Connection.new(endpoint, params, config)
      @connection.request!
    end
    
    # Returns current client's rate limit values. If it gets failed,
    # nil will be returned.
    # 
    # @return [Hash, nil] A hash of result. See
    #   http://docs.aylien.com/docs/rate-limits for more information
    #   on the data returned.
    def rate_limits
      self.language text: "Hello world!" unless defined?(@connection)
      
      (@connection || {}).rate_limits
    end
    
    private

    def validate_uri(value)
      value =~ /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z/ix
    end

    def common_endpoint(value, params, endpoint)
      if value.is_a?(Hash)
        params = value
        value = nil
      end
      if value && (!params[:url] || !params[:text] && !params[:title])
        value.strip!
        if validate_uri(value)
          params[:url] = value
        elsif endpoint == Configuration::ENDPOINTS[:related]
          params[:phrase] = value
        else
          params[:text] = value
        end
      end
      
      if endpoint == Configuration::ENDPOINTS[:classify_by_taxonomy]
        if params[:taxonomy] && !params[:taxonomy].empty?
          endpoint = Configuration::ENDPOINTS[:classify_by_taxonomy]
            .gsub(/\:taxonomy/, params[:taxonomy])
        else
          error_message = "Invalid taxonomy. Taxonomy can't be blank."
          error = AylienTextApi::Error::InvalidInput.new(error_message)
          raise error
        end
      end
      
      config = {}
      Configuration::VALID_CONFIG_KEYS.each do |key|
        config[key] = send(key)
      end
      [endpoint, params, config]
    end
  end # Client
end
