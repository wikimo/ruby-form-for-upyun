require "upyun/form/version"
require 'faraday'
require 'securerandom'
require 'base64'
require 'json'

module Upyun
  module Form

    class Uploader

    	def initialize(bucket, form_api_secret, endpoint=0)
    		@bucket = bucket
    		@form_api_secret = form_api_secret
    		@url = "http://v#{endpoint}.api.upyun.com"
    		@conn = Faraday.new(@url) do |f|
				  f.request :multipart
				  f.request :url_encoded
				  f.adapter :net_http
				end
    	end

    	def put(file)
    		opt = {}
				opt['bucket'] =  @bucket
				opt['save-key'] =  '/demo/' + SecureRandom.uuid + '.jpeg'
				opt['expiration'] = Time.now.to_i + 600

				policy = Base64.encode64(opt.to_json).gsub(/\n/,'')
				sign =  Digest::MD5.hexdigest("#{policy}&#{@form_api_secret}")

				response = @conn.post("#{@bucket}", {:policy => policy,
					:signature => sign,
					:file => Faraday::UploadIO.new(file, 'image/jpeg') })

				p "debug ==> #{response.body}"
    	end

    end	
  end
end
