# Ruby Form For Upyun

upload photo to upyun with form

## Enviroment
ruby 2.1.1

## Installation

Add this line to your application's Gemfile:

    gem 'upyun-form'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install upyun-form

## Usage

```
require 'upyun/form'
# watermark_path 需要是同一bucket文件url
watermark_path64 = Base64.encode64("/"+watermark_path).gsub(/\n/,'')

config = {:bucket => 'devel',
					:secret => 'lRJmqjI19GxB80KJc7y7NOcI+8g=',
					# :return_url => 'http://localhost/return_url',
					:notify_url => 'http://dev.365jinbi.com/notify.php',
          #:content_secret => "123123123",
          :apps => [{
                            "name" => "thumb",
                            "x-gmkerl-thumb" => "/fwfh/900x900/watermark/url/#{watermark_path64}/align/southeast/margin/5x5",
                            "save_tag" => "x900"
                          },{
                            "name" => "thumb",
                            "x-gmkerl-thumb" => "/fwfh/200x200",
                            "save_tag" => "x200"
                }]
           }

uploader = Upyun::Form::Uploader.new config

```

when no return url,it will return a json obj contains  http code, message and photo url 

when you set return url,it will return a response_headers contains location url

when you set notify url,it will post the result to that url,in this demo,it will notify the url http://dev.365jinbi.com/notify.php, you can browser http://dev.365jinbi.com/upyun.log to see the result


## Update Log
* add rspec test
