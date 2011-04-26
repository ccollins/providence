require 'spec_helper'

module Providence
  describe BaseWatchr do
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
      it "should take accept no args" do
        bw = BaseWatchr.new
        bw.watchrs.count.should == 0
      end
      
      it "should take multiple args" do
        bw = BaseWatchr.new(Object.new, Object.new, Object.new)
        bw.watchrs.count.should == 3
      end
    end
    
    context "#watchrs" do
      it "should accept multiple objects" do
        subject.watchrs << Object.new << Object.new
        subject.watchrs.count.should == 2
      end
    end
    
    context "#run_suite" do
      it "should call run_all on each watchr" do
        5.times do
          watchr = mock()
          watchr.expects(:run_all).once
          subject.watchrs << watchr
        end
        
        subject.run_suite
      end
    end
    
    context "#run_suite" do
      it "should call watch on each watchr" do
        5.times do
          watchr = mock()
          watchr.expects(:watch).once
          subject.watchrs << watchr
        end
        
        subject.watch
      end
    end
  end
end