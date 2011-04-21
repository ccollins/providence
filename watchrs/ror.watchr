ENV["WATCHR"] = "1"

$cuke_cmd = 

$pass = File.join(File.expand_path(File.dirname(__FILE__)), 'images', 'red-green-yellow', 'pass.png')
$fail = File.join(File.expand_path(File.dirname(__FILE__)), 'images', 'red-green-yellow', 'fail.png')
$pending = File.join(File.expand_path(File.dirname(__FILE__)), 'images', 'red-green-yellow', 'pending.png')



@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    @wants_to_quit = true
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
  end
end

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running full suite ---\n\n"
  run_suite
end

providence = Providence.new(RspecWatchr.new, CucumberWatchr.new)
providence.watch