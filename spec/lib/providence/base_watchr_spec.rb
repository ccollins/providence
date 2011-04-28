require 'spec_helper'

module Providence
  describe BaseWatchr do
    before(:each) do
      @base_watchr = BaseWatchr.new(mock())
    end
    
    it "should have an image for passing tests" do
      File.exists?(BaseWatchr.pass_image).should be_true
    end

    it "should have an image for failing tests" do
      File.exists?(BaseWatchr.fail_image).should be_true
    end
    
    it "should have an image for pending" do
      File.exists?(BaseWatchr.pending_image).should be_true
    end
    
    context "#initialize" do
      it "should take accept context and no args" do
        bw = BaseWatchr.new(mock())
        bw.watchrs.count.should == 0
      end
      
      it "should take context and multiple args" do
        bw = BaseWatchr.new(mock(), Object.new, Object.new, Object.new)
        bw.watchrs.count.should == 3
      end
    end
    
    context "#watchrs" do
      it "should accept multiple objects" do
        @base_watchr.watchrs << Object.new << Object.new
        @base_watchr.watchrs.count.should == 2
      end
    end
    
    context "#run_suite" do
      it "should call run_all on each watchr" do
        5.times do
          watchr = mock()
          watchr.expects(:run_all).once
          @base_watchr.watchrs << watchr
        end
        
        @base_watchr.run_suite
      end
    end
    
    context "#run_suite" do
      it "should call watch on each watchr" do
        5.times do
          watchr = mock()
          watchr.expects(:watch).once
          @base_watchr.watchrs << watchr
        end
        
        @base_watchr.watch
      end
    end
  end
end