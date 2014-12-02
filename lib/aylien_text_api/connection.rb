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

require 'json'
require 'logger'
require 'uri'
require 'net/http'

module AylienTextApi
  class Connection
    def initialize(endpoint, params, config)
      @config = config
      @uri = URI.join(@config[:base_uri], endpoint.to_s)
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
      Net::HTTP.start(@uri.host, @uri.port, use_ssl: (@uri.scheme == 'https')) do |http|
        response = http.request(@request)
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
      if @config[:method] == :post
        request = Net::HTTP::Post.new(@uri.request_uri)
        request.set_form_data(@params)
      elsif @config[:method] == :get
        @uri.query = URI.encode_www_form(@params)
        request = Net::HTTP::Get.new(@uri.request_uri)
      end

      request['app_id'] = @config[:app_id]
      request['app_key'] = @config[:app_key]
      request['user-agent'] = @config[:user_agent]

      @request = request
    end
  end
end
