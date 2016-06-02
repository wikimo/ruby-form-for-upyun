require "upyun/form/version"
require 'faraday'
require 'securerandom'
require 'base64'
require 'json'
require 'mime/types'

module Upyun
  module Form

    class Uploader

      def initialize(config)
        @config =  config

        @bucket = @config[:bucket]
        @form_api_secret = @config[:secret]
        endpoint =  @config[:endpoint] ? @config[:endpoint] : 0
        @allow_file_types = ['jpg','jpeg','png','gif']

        @url = "http://v#{endpoint}.api.upyun.com"
        @conn = Faraday.new(@url) do |f|
          f.request :multipart
          f.request :url_encoded
          f.adapter :net_http
        end

      end

      def put(file)
        mime_type =  MIME::Types.type_for(file).first
        return false  if !@allow_file_types.include? mime_type.sub_type

        opt = {}
        opt['bucket'] =  @bucket
        save_path =  @config[:save_path] ? @config[:save_path] : Time.now.strftime("%Y-%m-%d")
        opt['save-key'] =  "/#{save_path}/#{SecureRandom.uuid}.#{mime_type.sub_type}"
        opt['expiration'] = Time.now.to_i + 600

        opt['return-url'] = @config[:return_url] if @config[:return_url] != ''
        opt['notify-url'] = @config[:notify_url] if @config[:notify_url] != ''
        opt['apps'] = @config[:apps] if @config[:apps] != ''

        policy = Base64.encode64(opt.to_json).gsub(/\n/,'')
        sign =  Digest::MD5.hexdigest("#{policy}&#{@form_api_secret}")

        response = @conn.post("#{@bucket}", {:policy => policy,
                                             :signature => sign,
                                             :file => Faraday::UploadIO.new(file, mime_type.content_type) })

        if @config[:return_url]
          return response.env.response_headers
        end

        json = JSON.parse response.body
        {code: json['code'], msg: json['message'], url: json['url']}
      end

    end
  end
end
