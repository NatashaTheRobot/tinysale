require 'spec_helper'

describe Payment do
  it { should belong_to :user }

  describe ".create_from_tokens" do
    before do
      @user = FactoryGirl.create :user
    end
    context "with the correct response from stripe" do
      before do
        Payment.stub(:add_tokens).and_return({"access_token"=>"sk_test_PgQdLXYq138CFKzcotHiBQb6",
                                              "refresh_token"=>"rt_0yjiQyzuHLzBPFmzbfDm06GkL90pcOOknVjqrEGO6TE4rJUQ",
                                              "token_type"=>"bearer", "scope"=>"read_only",
                                              "stripe_user_id"=>"acct_0quRJAW5yVxOwiv4TuzG",
                                              "livemode"=>false,
                                              "stripe_publishable_key"=>"pk_test_2wSgxfxY09f7MUltpUUhZ9YT"})
      end
      it "stores the user's payment information" do
        expect {
          payment = Payment.create_from_tokens(@user, "ac_0yk86zbFJvt80SiYZtXNfmO1Bc5GtqgK")
          }.should change(Payment, :count).by(1)
        payment.should be_an_instance_of Payment
        payment.access_token.should eq "sk_test_PgQdLXYq138CFKzcotHiBQb6"
        payment.publishable_key.should eq "pk_test_2wSgxfxY09f7MUltpUUhZ9YT"
      end
    end
    context "with an error response from stripe" do
      before do
        Payment.stub(:add_tokens).and_return({"error"=> "invalid params"})
      end
      it "returns an error" do
        payment = Payment.create_from_tokens(@user, "bad code")
        payment.should eq :error
      end
    end
  end
end
