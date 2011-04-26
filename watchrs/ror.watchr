require File.join(File.dirname(__FILE__), '..', 'lib', 'providence')

ENV["WATCHR"] = "1"
@providence = Providence::BaseWatchr.new(Providence::RspecWatchr.new)
@providence.peep