module Providence
  class BaseWatchr
    class << self
      def run(path)  
        cmd = "#{command} #{path}"
  
        Eye.growl "Running #{name}"
        system('clear')
        puts(cmd)
        
        status = parse_test_status(run_command(cmd))
        Eye.growl send("#{status}_message".to_sym), Eye.send("#{status}_image".to_sym)
      end
      
      def run_command(cmd)
        last_output = []
        stdin, stdout, stderr = Open3.popen3(cmd)
        while !stdout.eof? || !stderr.eof
          err = stderr.gets
          puts err unless err.nil? || err.strip.empty?
          
          line = stdout.gets
          last_output.replace([]) if line.nil? || line.strip.empty?
          last_output.push(line)
          puts line         
        end
      
        stdin.close
        stdout.close
        stderr.close
        
        last_output
      end
      
      def pass_message; 'Passed'; end
      def fail_message; 'Failed'; end
      def pending_message; 'Pending further work'; end
      def alert_message; 'Cannot determine test status'; end
    end
  end
end