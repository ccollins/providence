require File.join(File.dirname(__FILE__), '..', 'lib', 'providence')

#TODO catch startup errors
ENV["WATCHR"] = "1"
@providence = Providence::BaseWatchr.new(self, File.dirname(__FILE__), Providence::RspecWatchr.new, Providence::CucumberWatchr.new)
@providence.watch