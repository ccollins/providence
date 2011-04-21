module Providence
  class CucumberWatchr < Providence
    attr_accessor :cucumber
    
    def watch
      watch('features/support/.*')  { |m| run_all }
      watch('features/.*\.feature') { |m| run m[0] }
    end
    
    def growl(message='')
      if message.match(/failed/)
        title = 'Watchr: Scenarios are failing'
        image = $fail
      elsif message.match(/passed/)
        title = 'Watchr: All scenarios passed'
        image = $pass
      elsif message.match(/undefined/)
        title = 'Watchr: Undefined Steps'
        image = $pending
      else
        title = 'Watchr: Running features'
        message = 'Running features'
        image = $pending
      end
      Growl.notify message, :icon => image, :title => title
    end

    def run(feature_path)  
      cmd = "#{cucumber} #{feature_path}"
  
      growl_feature
      system('clear')
      puts(cmd)
  
      last_output = []
      stdin, stdout, stderr = Open3.popen3(cmd)
      stdout.each_line do |line|
        last_output.replace([]) if line.strip.empty?
        last_output.push(line)
        puts line
      end
      stderr.each_line do |line|
        last_output = line
        puts line
      end
      stdin.close
      stdout.close
      stderr.close
  
      growl_feature last_output.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
    end

    def run_all
      run 'features'
    end
    
    def cucumber
      "cucumber --color --drb --require features/step_definitions --require features/support"
    end
  end
end