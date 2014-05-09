require File.dirname(__FILE__) + '/spec_helper'
require 'open-uri'

describe 'Upyun' do
	before :all do
		@config = {:bucket => 'devel',
					:secret => 'lRJmqjI19GxB80KJc7y7NOcI+8g='
				}

    
	end	

	it 'put file without return url' do

		@uploader = Upyun::Form::Uploader.new @config

		json = @uploader.put './test.jpeg'
		
		expect(json[:code]).to eq  200
	end	

	it 'put file with return url' do
		@config[:return_url] = 'http://localhost'

		@uploader = Upyun::Form::Uploader.new @config

		response = @uploader.put './test.jpeg'
		expect(response['location']).to include @config[:return_url]
	end	

	it 'put file with notify url' do
		@config[:notify_url] = 'http://dev.365jinbi.com/notify.php'

		@uploader = Upyun::Form::Uploader.new @config
		json = @uploader.put './test.jpeg'

		sleep 5

		notify_info  = open('http://dev.365jinbi.com/upyun.log').read
		expect(notify_info).to include json[:url]
	end	
end