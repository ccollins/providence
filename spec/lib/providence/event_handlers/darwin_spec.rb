require 'spec_helper'

def tempfile(name)
  file = Tempfile.new(name)
  Pathname(file.path)
ensure
  file.close
end

module Providence
  module EventHandler
    describe Darwin do
      before(:each) do
        @foo = tempfile('foo').expand_path
        @bar = tempfile('bar').expand_path
        subject.stubs(:run)
        subject.stubs(:stop)
      end
      
      context "#listen" do
        it "should trigger listening state" do
          subject.expects(:run)
          subject.expects(:watch_paths)
          subject.listen([])
        end
        
        it "should listen for events on monitored files" do
          subject.listen([@foo, @bar])
          subject.watched_paths.include?(@foo).should be_true
          subject.watched_paths.include?(@bar).should be_true
        end
        
        it "should reattach to new monitored files" do
          subject.listen([@foo, @bar])
          
          @baz = tempfile('baz').expand_path
          @bax = tempfile('bax').expand_path
          subject.refresh([@baz, @bax])
          
          subject.watched_paths.include?(@baz).should be_true
          subject.watched_paths.include?(@bax).should be_true
          subject.watched_paths.include?(@foo).should be_false
          subject.watched_paths.include?(@bar).should be_false
        end
      end
      
      context "#process_changes" do
        it "should notify deleted event" do
          @foo.stubs(:exist?).returns(false)
          subject.listen([@foo, @bar])
          subject.expects(:notify).with(@foo, :deleted)
          subject.send(:process_changes, [Dir::tmpdir])
        end

        it "should notify modified event" do
          @foo.stubs(:mtime).returns(Time.now + 100)
          subject.listen([@foo, @bar])
          subject.expects(:notify).with(@foo, :modified)
          subject.send(:process_changes, [Dir::tmpdir])
        end
        
        it "should notify accessed event" do
          @foo.stubs(:atime).returns(Time.now + 100)
          subject.listen([@foo, @bar])
          subject.expects(:notify).with(@foo, :accessed)
          subject.send(:process_changes, [Dir::tmpdir])
        end
        
        it "should notify changed file event" do
          @foo.stubs(:ctime).returns(Time.now + 100)
          subject.listen([@foo, @bar])
          subject.expects(:notify).with(@foo, :changed)
          subject.send(:process_changes, [Dir::tmpdir])
        end
      end
    end
  end
end