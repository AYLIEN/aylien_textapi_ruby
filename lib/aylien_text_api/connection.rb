# Copyright 2016 Aylien, Inc. All Rights Reserved.
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

require 'json'
require 'logger'
require 'uri'
require 'net/http'

module AylienTextApi
  class Connection
    attr_reader :rate_limits
    
    def initialize(endpoint, params, config)
      @config = config
      @uri = URI.join(@config[:base_uri], endpoint)
      @params = params
      compile_request_params
    end

    def request
      begin
        request!
      rescue => e
        logger = Logger.new(STDOUT)
        logger.level = Logger::ERROR
        logger.info(e)
        nil
      end
    end

    def request!
      Net::HTTP.start(@uri.host, @uri.port, :ENV, use_ssl: (@uri.scheme == 'https')) do |http|
        response = http.request(@request)
        
        limit = response["X-RateLimit-Limit"]
        remaining = response["X-RateLimit-Remaining"]
        reset = response["X-RateLimit-Reset"]
        
        @rate_limits = {
          limit: limit ? limit.to_i : nil,
          remaining: remaining ? remaining.to_i : nil,
          reset: reset ? reset.to_i : nil
        }
        
        if response.kind_of?(Net::HTTPSuccess)
          JSON.parse(response.body, :symbolize_names => true)
        else
          klass = AylienTextApi::Error::ERRORS[response.code.to_i]
          error = klass.nil? ? AylienTextApi::Error.new(response.body) : klass.from_response(response)
          raise error
        end
      end
    end

    private

    def compile_request_params
      @params[:class] = @params.delete(:classes) if @params[:classes]
      
      if @config[:method] == :post
        request = Net::HTTP::Post.new(@uri.request_uri)
        request.set_form_data(@params)
      elsif @config[:method] == :get
        @uri.query = URI.encode_www_form(@params)
        request = Net::HTTP::Get.new(@uri.request_uri)
      end

      request['X-AYLIEN-TextAPI-Application-ID'] = @config[:app_id]
      request['X-AYLIEN-TextAPI-Application-Key'] = @config[:app_key]
      request['user-agent'] = @config[:user_agent]

      @request = request
    end
  end
end
