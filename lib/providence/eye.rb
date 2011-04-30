module Providence
  class Eye
    attr_accessor :watchrs, :ec

    class << self
      def get_image(image_name)
        File.join(File.expand_path(File.dirname(__FILE__)), '..', '..', 'images', 'glass', "#{image_name}.png")
      end
      
      def method_missing(sym, *arguments, &block)
        if sym.to_s =~ /^(.*)_image$/
          get_image($1)
        else
          super
        end
      end
      
      def growl(message, image=info_image, title='Providence')
        Growl.notify message, :title => title, :icon => image
      end
    end
    
    def initialize eval_context, *args
      @ec = eval_context
      @watchrs = args || []
    end
  
    def run_suite
      watchrs.each {|w| w.class.run_all }
    end
    
    def watch
      watchrs.each {|w| w.watch(ec) }
    end
  end
end