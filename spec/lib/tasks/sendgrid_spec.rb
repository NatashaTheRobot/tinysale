describe Sendgrid do

  describe ".add_to_launch_list" do
    it "returns a response" do
      Sendgrid.add_to_launch_list('test@example.com')['error'].should eq "Bad username / password"
    end
  end

end