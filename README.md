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

config = {:bucket => 'devel',
					:secret => 'lRJmqjI19GxB80KJc7y7NOcI+8g=',
					# :return_url => 'http://localhost/return_url',
					:notify_url => 'http://dev.365jinbi.com/notify.php' }

uploader = Upyun::Form::Uploader.new config

```

when no return url,it will return a json obj contains  http code, message and photo url 

when you set return url,it will return a response_headers contains location url

when you set notify url,it will post the result to that url,in this demo,it will notify the url http://dev.365jinbi.com/notify.php, you can browser http://dev.365jinbi.com/upyun.log to see the result


## Update Log
* add rspec test
