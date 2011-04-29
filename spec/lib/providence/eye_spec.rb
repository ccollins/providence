require 'spec_helper'

module Providence
  describe Eye do
    before(:each) do
      @base_watchr = Eye.new(mock())
    end
    
    it "should not have an image for asdf" do
      File.exists?(Eye.asdf_image).should_not be_true
    end
    
    it "should have an image for passing tests" do
      File.exists?(Eye.pass_image).should be_true
    end

    it "should have an image for failing tests" do
      File.exists?(Eye.fail_image).should be_true
    end
    
    it "should have an image for pending" do
      File.exists?(Eye.pending_image).should be_true
    end
    
    it "should have an image for alert" do
      File.exists?(Eye.alert_image).should be_true
    end
    
    it "should have an image for info" do
      File.exists?(Eye.info_image).should be_true
    end
    
    it "should return the image" do
      Eye.get_image('pending').should =~ /pending\.png/
    end
    
    context "#initialize" do
      it "should take accept context and no args" do
        bw = Eye.new(mock())
        bw.watchrs.count.should == 0
      end
      
      it "should take context and multiple args" do
        bw = Eye.new(mock(), Object.new, Object.new, Object.new)
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