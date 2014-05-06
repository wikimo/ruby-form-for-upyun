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

uploader = Upyun::Form::Uploader.new 'bucket', 'form_api_secret'

uploader.put './test.jpeg'

```

return a hash contains response code , message and photo url

## Contributing

1. Fork it ( https://github.com/[my-github-username]/upyun-form/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
