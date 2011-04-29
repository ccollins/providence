require 'growl'
require 'open3'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'providence/eye'
require 'providence/base_watchr'
require 'providence/cucumber_watchr'
require 'providence/rspec_watchr'
require 'providence/event_handlers/darwin'