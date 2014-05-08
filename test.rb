lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upyun/form'

url = 'http://devel.b0.upaiyun.com'

config = {:bucket => 'devel',
					:secret => 'lRJmqjI19GxB80KJc7y7NOcI+8g=',
					# :return_url => 'http://localhost/return_url',
					:notify_url => 'http://dev.365jinbi.com/notify.php' }

uploader = Upyun::Form::Uploader.new config

result = uploader.put './test.jpeg'

p result
# p "url ==> #{url}#{result[:url]}"