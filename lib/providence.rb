require 'growl'
require 'open3'

require 'providence/cucumber'
require 'providence/rspec'

class Providence
  attr_accessor :watchrs
  
  def watchrs
    @watchrs || []
  end
  
  def run_suite
    watchrs.each {|w| w.run_all }
  end
end
  