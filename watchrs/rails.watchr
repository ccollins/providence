require File.join(File.dirname(__FILE__), '..', 'lib', 'providence')  

@eye = Providence::Eye.new(self, Providence::RspecWatchr.new, Providence::CucumberWatchr.new)
@eye.watch