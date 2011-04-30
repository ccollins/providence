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
      def parse_test_status(status)
        status = status.join('').gsub(/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]/, '')

        if status.match(/\s0\s(errors|failures)/)
          status.match(/pending/) ? :pending : :pass
        elsif status.match(/(error|failure)/)
          :fail
        else
          :alert
        end
      end

      def run_all
        run 'spec'
      end

      def related(path)
        Dir['spec/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_spec.rb/ }
      end

      def command
        if Gem.searcher.find('rspec').nil?
          "env RSPEC_COLOR=true spec --drb --colour --format nested"
        else
          "rspec --tty --drb --colour --format nested"
        end
      end
    end
  end
end