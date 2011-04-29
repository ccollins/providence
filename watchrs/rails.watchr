require File.join(File.dirname(__FILE__), '..', 'lib', 'providence')  

@providence = Providence::Eye.new(self, Providence::RspecWatchr.new, Providence::CucumberWatchr.new)
@providence.watch

Signal.trap 'QUIT' do # Ctrl-\
  puts " --- Running full test suite ---\n\n"
  @providence.run_suite
end

@interrupted = false
Signal.trap 'INT' do  # Ctrl-C
  if @interrupted
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
  end
end