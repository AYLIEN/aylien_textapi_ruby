# Copyright 2014 Aylien, Inc. All Rights Reserved.
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

    # Creates an Client object.
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

      Configuration::ENDPOINTS.each do |endpoint|
        self.class.send(:define_method, "#{endpoint}!") do |value=nil, params={}|
          endpoint, params, config = common_endpoint(value, params, endpoint)
          Connection.new(endpoint, params, config).request!
        end
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
    #   http://aylien.com/text-api-doc#extract for more information
    #   on the data returned.
    #
    def extract(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :extract)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#classify for more information
    #   on the data returned.
    #
    def classify(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :classify)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#concepts for more information
    #   on the data returned.
    #
    def concepts(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :concepts)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#hashtags for more information
    #   on the data returned.
    #
    def hashtags(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :hashtags)
      Connection.new(endpoint, params, config).request
    end

    # Extracts named entities (people, organizations and locations) and
    # values (URLs, emails, telephone numbers, currency amounts and percentages)
    # mentioned in a body of text.
    #
    # @param [String] value (nil) URL or Text
    # @param [Hash] params The entities endpoint options
    # @option params [String] :url The URL
    # @option params [String] :text Text
    #
    # @return [Hash, nil] A hash of result. See
    #   http://aylien.com/text-api-doc#entities for more information
    #   on the data returned.
    #
    def entities(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :entities)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#language for more information
    #   on the data returned.
    #
    def language(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :language)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#sentiment for more information
    #   on the data returned.
    #
    def sentiment(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :sentiment)
      Connection.new(endpoint, params, config).request
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
    #
    # @return [Hash, nil] A hash of result. See
    #   http://aylien.com/text-api-doc#summarize for more information
    #   on the data returned.
    #
    def summarize(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :summarize)
      Connection.new(endpoint, params, config).request
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
    #   http://aylien.com/text-api-doc#related for more information
    #   on the data returned.
    #
    def related(value=nil, params={})
      endpoint, params, config = common_endpoint(value, params, :related)
      Connection.new(endpoint, params, config).request
    end

    private

    def validate_uri(value)
      value =~ /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix
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
        elsif endpoint == :related
          params[:phrase] = value
        else
          params[:text] = value
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
