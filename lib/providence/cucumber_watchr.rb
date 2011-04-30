module Providence
  class CucumberWatchr < BaseWatchr
    #order matters here, top is last to match, bottom is first
    def watch(ec)
      ec.watch('features/support/.*')  { |m| Providence::CucumberWatchr.run_all }
      ec.watch('features/.*\.feature') { |m| Providence::CucumberWatchr.run m[0] }
    end
    
    class << self
      def parse_test_status(status)
        status = status.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')
        
        if status.match(/failed/)
          :fail
        elsif status.match(/passed/)
          :pass
        elsif status.match(/undefined/)
          :pending
        else
          :alert
        end        
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