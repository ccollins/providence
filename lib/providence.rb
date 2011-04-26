require 'growl'
require 'open3'

$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'providence/base_watchr'
require 'providence/cucumber_watchr'
require 'providence/rspec_watchr'

@interrupted = false
# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
  end
end

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running full test suite ---\n\n"
  @providence.run_suite
end
  