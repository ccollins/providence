require 'spec_helper'

module Providence
  describe BaseWatchr do
    it "should respond to run" do
      BaseWatchr.respond_to?(:run).should be_true
    end
    
    it "should respond to run_command" do
      BaseWatchr.respond_to?(:run_command).should be_true
    end
    
    context "#messages" do
      it "should return a string for passing" do
        message = BaseWatchr.pass_message
        message.is_a?(String).should be_true
        message.should_not be_empty
      end
      
      it "should return a string for failing" do
        message = BaseWatchr.fail_message
        message.is_a?(String).should be_true
        message.should_not be_empty
      end
      
      it "should return a string for pending" do
        message = BaseWatchr.pending_message
        message.is_a?(String).should be_true
        message.should_not be_empty
      end
      
      it "should return a string for alert" do
        message = BaseWatchr.alert_message
        message.is_a?(String).should be_true
        message.should_not be_empty
      end
    end
    
    context "#run" do
      before(:each) do
        BaseWatchr.stubs(:command).returns('test')
        BaseWatchr.stubs(:puts)
        BaseWatchr.stubs(:system)
        Eye.stubs(:growl)
      end
      
      it "should growl and output command and status" do
        BaseWatchr.expects(:run_command).with("test #{Dir::tmpdir}").returns('run_command')
        BaseWatchr.expects(:parse_test_status).with('run_command').returns(:pass)
        BaseWatchr.expects(:pass_message)
        BaseWatchr.run(Dir::tmpdir)
      end
    end
  end
end