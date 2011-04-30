require 'spec_helper'

module Providence
  describe RspecWatchr do
    it "should respond to watch" do
      subject.respond_to?(:watch).should be_true
    end
    
    it "should run all features" do
      RspecWatchr.expects(:run).with('spec')
      RspecWatchr.run_all
    end
    
    context "#command" do
      it "should return rspec if rspec gem is found" do
        Gem.stubs(:searcher).returns(mock(:find => true))
        RspecWatchr.command =~ /rspec/
      end
      
      it "should return spec without rspec gem" do
        Gem.stubs(:searcher).returns(mock(:find => nil))
        command = RspecWatchr.command
        command =~ /spec/ and command =~ /env/
      end
    end
    
    context "#parse_test_status" do
      it "should return :fail" do
        RspecWatchr.parse_test_status(['5 examples, 1 failure']).should == :fail
      end
      
      it "should return :pass" do
        RspecWatchr.parse_test_status(['5 examples, 0 failures']).should == :pass
      end
      
      it "should return :pending" do
        RspecWatchr.parse_test_status(['5 examples, 0 failures, 1 pending']).should == :pending
      end
      
      it "should return :alert" do
        RspecWatchr.parse_test_status(['hrrrgrrrrrbrbrlrllrl']).should == :alert
      end
    end
  end
end