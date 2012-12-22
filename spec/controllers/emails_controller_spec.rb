require 'spec_helper'

describe EmailsController do
  describe "#create" do
    context "with a bad email" do
      it "returns an 422 response" do
        post :create, email: 'bademail'
        response.code.should eq "422"
      end
    end
    context "with a good email" do
      before do
        Sendgrid.stub(:add_to_launch_list).and_return("inserted" => 1)
      end
      it "returns a success response" do
        Sendgrid.should_receive(:add_to_launch_list).once
        post :create, email: "natasha@test.com"
        response.should be_success
      end
    end
  end
end