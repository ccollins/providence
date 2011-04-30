require 'spec_helper'

module Providence
  describe CucumberWatchr do
    it "should respond to watch" do
      subject.respond_to?(:watch).should be_true
    end
    
    it "should run all features" do
      CucumberWatchr.expects(:run).with('features')
      CucumberWatchr.run_all
    end
    
    it "should return cucumber in command" do
      CucumberWatchr.command =~ /cucumber/
    end
    
    context "#parse_test_status" do
      it "should return :fail" do
        CucumberWatchr.parse_test_status(['failed']).should == :fail
      end
      
      it "should return :pass" do
        CucumberWatchr.parse_test_status(['passed']).should == :pass
      end
      
      it "should return :pending" do
        CucumberWatchr.parse_test_status(['undefined']).should == :pending
      end
      
      it "should return :alert" do
        CucumberWatchr.parse_test_status(['hrrrgrrrrrbrbrlrllrl']).should == :alert
      end
    end
  end
end