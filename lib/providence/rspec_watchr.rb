module Providence
  class RspecWatchr < BaseWatchr
    #order matters here, top is last to match, bottom is first
    def watch(ec)
      ec.watch('app/.*\.rb')        { |m| Providence::RspecWatchr.related(m[0]).map {|tf| Providence::RspecWatchr.run tf } }
      ec.watch('lib/.*\.rb')        { |m| Providence::RspecWatchr.related(m[0]).map {|tf| Providence::RspecWatchr.run tf } }
      ec.watch('spec/support/.*')   { Providence::RspecWatchr.run_all }
      ec.watch('spec/.*_spec\.rb')  { |m| Providence::RspecWatchr.run m[0] }
    end
    
    class << self
      def growl_test_status(status)
        status = status.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')

        if status.match(/\s0\s(errors|failures)/)
          if status.match(/pending/)
            message = 'Pending specs, all others passing'
            image = Eye.pending_image
          else
            message = 'All specs passed'
            image = Eye.pass_image  
          end
        elsif status.match(/(error|failure)/)
          message = 'Specs are failing'
          image = Eye.fail_image
        else
          message = 'Cannot determine test status'
          image = Eye.alert_image
        end
        
        Eye.growl message, image
      end

      def run_all
        run 'spec'
      end

      def related(path)
        Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
      end

      def command
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
end