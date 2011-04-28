module Providence
  class RspecWatchr
    attr_accessor :spec
    
    def initialize; end
    
    def watch(ec)
      ec.watch('spec/support/.*')      { Providence::RspecWatchr.run_all }
      ec.watch('spec/.*_spec\.rb')     { |m| Providence::RspecWatchr.run m[0] }
      ec.watch('app/.*\.rb')           { |m| Providence::RspecWatchr.related(m[0]).map {|tf| Providence::RspecWatchr.run tf } }
      ec.watch('lib/.*\.rb')           { |m| Providence::RspecWatchr.related(m[0]).map {|tf| Providence::RspecWatchr.run tf } }
    end
    
    def self.growl(message='')
      if message.match(/\s0\s(errors|failures)/)
        title = 'Watchr: All specs passed'
        image = BaseWatchr.pass_image
      elsif message.match(/(error|failure)/)
        title = 'Watchr: Specs are failing'
        image = BaseWatchr.fail_image
      elsif message.match(/pending/)
        title = 'Watchr: Pending specs'
        image = BaseWatchr.pending_image
      else
        title = 'Watchr: Running specs'
        message = 'Running specs'
        image = BaseWatchr.pending_image
      end
      Growl.notify message, :icon => image, :title => title
    end

    def self.run(spec_path)
      cmd = "#{Providence::RspecWatchr.spec} #{spec_path}"
  
      Providence::RspecWatchr.growl 'Running specs...'
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
  
      Providence::RspecWatchr.growl last_output.gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
    end

    def self.run_all
      Providence::RspecWatchr.run 'spec'
    end

    def self.related(path)
      Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
    end

    def self.spec
      rspec_version = Gem.searcher.find('rspec').version.version.to_s.split('.')[0]
      case rspec_version
      when "1"
        "env RSPEC_COLOR=true rspec --drb --colour --format nested"
      when "2"
        "rspec --tty --drb --colour --format nested"
      end
    end
  end
end