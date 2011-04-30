require 'spec_helper'

module Providence
  describe Eye do
    before(:each) do
      @eye = Eye.new(mock())
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
        eye = Eye.new(mock())
        eye.watchrs.count.should == 0
      end
      
      it "should take context and multiple args" do
        eye = Eye.new(mock(), Object.new, Object.new, Object.new)
        eye.watchrs.count.should == 3
      end
    end
    
    context "#watchrs" do
      it "should accept multiple objects" do
        @eye.watchrs << Object.new << Object.new
        @eye.watchrs.count.should == 2
      end
    end
    
    context "#run_suite" do
      it "should call watch on each watchr" do
        5.times do
          @eye.watchrs << RspecWatchr.new
        end
        RspecWatchr.expects(:run_all).times(5)
        @eye.run_suite
      end
    end
    
    context "#watch" do
      it "should call watch on each watchr" do
        5.times do
          watchr = mock()
          watchr.expects(:watch).once
          @eye.watchrs << watchr
        end
        
        @eye.watch
      end
    end
  end
end