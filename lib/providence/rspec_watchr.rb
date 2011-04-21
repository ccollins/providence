module Providence
  class RspecWatchr < Providence
    attr_accessor :spec
    
    def watch
      watch('spec/spec_helper\.rb') { run_all }
      watch('spec/support/.*')      { run_all }
      watch('spec/.*_spec\.rb')     { |m| run m[0] }
      watch('app/.*\.rb')           { |m| related(m[0]).map {|tf| run tf } }
    end
    
    def growl(message='')
      if message.match(/\s0\s(errors|failures)/)
        title = 'Watchr: All specs passed'
        image = pass
      elsif message.match(/(error|failure)/)
        title = 'Watchr: Specs are failing'
        image = fail
      elsif message.match(/pending/)
        title = 'Watchr: Pending specs'
        image = pending
      else
        title = 'Watchr: Running specs'
        message = 'Running specs'
        image = pending
      end
      Growl.notify message, :icon => image, :title => title
    end

    def run(spec_path)
      cmd = "#{spec} #{spec_path}"
  
      growl
      system('clear')
      puts(cmd)
  
      last_output = ''
      stdin, stdout, stderr = Open3.popen3(cmd)
      stdout.each_line do |line|
        last_output = line
        puts line
      end
      stderr.each_line do |line|
        last_output = line
        puts line
      end
      stdin.close
      stdout.close
      stderr.close
  
      growl last_output.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
    end

    def run_all
      run 'spec'
    end

    def related(path)
      Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
    end
    
    def spec
      @spec ||= spec_command
    end
    
    protected
    def spec_command
      rspec_version = Gem.searcher.find('rspec').to_s.split('.')
      case rspec_version
      when 1
        "env RSPEC_COLOR=true rspec --drb --colour --format nested"
      when 2
        "rspec --tty --drb --colour --format nested"
      end
    end
  end
end