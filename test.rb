lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'upyun/form'

uploader = Upyun::Form::Uploader.new 'devel', 'lRJmqjI19GxB80KJc7y7NOcI+8g='

uploader.put './test.jpeg'