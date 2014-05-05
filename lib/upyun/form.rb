require "upyun/form/version"
require 'faraday'
require 'securerandom'
require 'base64'
require 'json'

module Upyun
  module Form
    # Your code goes here...
    class Uploader
    	def initialize
    		@conn = Faraday.new('http://v0.api.upyun.com') do |f|
				  f.request :multipart
				  f.request :url_encoded
				  f.adapter :net_http
				end
    	end

    	def upload(file)
    		opt = {}
				bucket = opt['bucket'] =  'devel'
				opt['save-key'] =  '/demo/' + SecureRandom.uuid + '.jpeg'
				opt['expiration'] = Time.now.to_i + 600
				form_api_secret = 'lRJmqjI19GxB80KJc7y7NOcI+8g='

				policy = Base64.encode64(opt.to_json).gsub(/\n/,'')

				sign =  Digest::MD5.hexdigest("#{policy}&#{form_api_secret}")

				url = "http://v0.api.upyun.com/#{bucket}"

				response = @conn.post("#{bucket}", {:policy => policy,
					:signature => sign,
					:file => Faraday::UploadIO.new(file, 'image/jpeg') })

				p "debug ==> #{response.body}"
    	end

    end	
  end
end
