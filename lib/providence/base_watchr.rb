module Providence
  class BaseWatchr
    attr_accessor :watchrs

    class << self
      def pass_image
        @pass_image ||= File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'images', 'red-green-yellow', 'pass.png')
      end
      
      def fail_image
        @fail_image ||= File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'images', 'red-green-yellow', 'fail.png')
      end
      
      def pending_image
        @pending_image ||= File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'images', 'red-green-yellow', 'pending.png')
      end
    end
    
    def initialize *args
      @watchrs = args || []
    end
  
    def run_suite
      watchrs.each {|w| w.run_all }
    end
    
    def peep
      watchrs.each {|w| w.peep }
    end
  end
end