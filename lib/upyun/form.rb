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
    		# @return_url =  return_url
    		# @notify_url =  notify_url 

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
				# opt['return-url'] = @return_url if @return_url != ''
				# opt['notify-url'] = @notify_url if @notify_url != ''

				policy = Base64.encode64(opt.to_json).gsub(/\n/,'')
				sign =  Digest::MD5.hexdigest("#{policy}&#{@form_api_secret}")

				response = @conn.post("#{@bucket}", {:policy => policy,
					:signature => sign,
					:file => Faraday::UploadIO.new(file, 'image/jpeg') })

				json = JSON.parse response.body
				{code: json['code'], msg: json['message'], url: json['url']}
    	end

    end	
  end
end
