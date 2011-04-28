module Providence
  class CucumberWatchr < Providence::BaseWatchr
    def initialize; end
    
    def watch(ec)
      ec.watch('features/support/.*')  { |m| Providence::CumberWatchr.run_all }
      ec.watch('features/.*\.feature') { |m| Providence::CumberWatchr.run m[0] }
    end
    
    def self.growl(message='')
      if message.match(/failed/)
        title = 'Watchr: Scenarios are failing'
        image = BaseWatchr.fail_image
      elsif message.match(/passed/)
        title = 'Watchr: All scenarios passed'
        image = BaseWatchr.pass_image
      elsif message.match(/undefined/)
        title = 'Watchr: Undefined Steps'
        image = BaseWatchr.pending_image
      else
        title = 'Watchr: Running cukes'
        message = 'Running cukes...'
        image = BaseWatchr.pending_image
      end
      Growl.notify message, :icon => image, :title => title
    end

    def self.run(feature_path)  
      cmd = "#{Providence::CumberWatchr.cucumber} #{feature_path}"
  
      Providence::CumberWatchr.growl
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
  
      Providence::CumberWatchr.growl last_output.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
    end

    def self.run_all
      Providence::CumberWatchr.run 'features'
    end
    
    def self.cucumber
      "cucumber --color --drb --require features/step_definitions --require features/support"
    end
  end
end