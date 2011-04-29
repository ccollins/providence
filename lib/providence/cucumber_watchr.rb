module Providence
  class CucumberWatchr < BaseWatchr
    #order matters here, top is last to match, bottom is first
    def watch(ec)
      ec.watch('features/support/.*')  { |m| Providence::CucumberWatchr.run_all }
      ec.watch('features/.*\.feature') { |m| Providence::CucumberWatchr.run m[0] }
    end
    
    class << self
      def growl_test_status(status)
        status = status.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
        
        if status.match(/failed/)
          message = 'Cukes are failing'
          image = Eye.fail_image
        elsif status.match(/passed/)
          message = 'All cukes passed'
          image = Eye.pass_image
        elsif status.match(/undefined/)
          message = 'Undefined steps'
          image = Eye.pending_image
        else
          message = 'Cannot determine test status'
          image = Eye.alert_image
        end
        
        Eye.growl message, image
      end

      def run_all
        run 'features'
      end
    
      def command
        "cucumber --color --drb --require features/step_definitions --require features/support"
      end
    end
  end
end