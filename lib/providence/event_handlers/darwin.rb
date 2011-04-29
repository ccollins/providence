require 'rb-fsevent'
require 'watchr/event_handlers/base'

module Providence
  module EventHandler
    # Uses ruby-fsevents (https://github.com/thibaudgg/rb-fsevent)
    class Darwin < FSEvent
      include Watchr::EventHandler::Base

      def initialize
        super
      end

      def listen(monitored_paths)
        watch_paths(monitored_paths)
        run
      end

      def refresh(monitored_paths)
        stop
        listen(monitored_paths)
      end

      private
      def watch_paths(paths)
        @watched_paths = paths
        watch(dirs_in(paths)) do |dirs|
          process_changes(dirs)          
        end
        update_reference_times
      end
      
      def dirs_in(paths)
        paths.map {|path| path.dirname.to_s }.uniq
      end

      def process_changes(dirs)
        dirs.each do |dir|
          paths = monitored_paths_for(dir)
          type  = nil
          path  = paths.find {|path| type = event_type(path) }
          notify(path, type) unless path.nil?
        end
        
        update_reference_times
      end

      def monitored_paths_for(dir)
        dir = Pathname(dir).expand_path
        @watched_paths.select {|path| path.dirname.expand_path == dir }
      end
      
      def event_type(path)
        return :deleted   if !path.exist?
        return :modified  if path.mtime > @reference_times[path][:mtime]
        return :accessed  if path.atime > @reference_times[path][:atime]
        return :changed   if path.ctime > @reference_times[path][:ctime]
        nil
      end

      def update_reference_times
        @reference_times = {}
        now = Time.now
        @watched_paths.each do |path|
          @reference_times[path] = {}
          @reference_times[path][:atime] = now
          @reference_times[path][:mtime] = now
          @reference_times[path][:ctime] = now
        end
      end
    end
  end
end
