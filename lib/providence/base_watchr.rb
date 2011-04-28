module Providence
  class BaseWatchr
    attr_accessor :watchrs, :ec

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
    
    def initialize eval_context, *args
      @ec = eval_context
      @watchrs = args || []
    end
  
    def run_suite
      watchrs.each {|w| w.run_all(ec) }
    end
    
    def watch
      watchrs.each {|w| w.watch(ec) }
    end
  end
end