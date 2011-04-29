module Providence
  class BaseWatchr
    class << self
      def run(path)  
        cmd = "#{command} #{path}"
  
        Eye.growl "Running #{name}"
        system('clear')
        puts(cmd)
  
        last_output = []
        stdin, stdout, stderr = Open3.popen3(cmd)
        while !stdout.eof? || !stderr.eof
          err = stderr.gets
          puts err unless err.nil? || err.strip.empty?
          
          line = stdout.gets
          last_output.replace([]) if line.strip.empty?
          last_output.push(line)
          puts line         
        end
  
        growl_test_status last_output
      
        stdin.close
        stdout.close
        stderr.close
      end
    end
  end
end