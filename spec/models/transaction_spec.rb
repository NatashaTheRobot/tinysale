require 'spec_helper'

describe Transaction do
  it { should belong_to :product }

  describe "after_save" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @transaction = FactoryGirl.build(:transaction, product: @product)
    end
    it "sends the product emails" do
      Product.any_instance.stub_chain(:attachments, :first, :item, :expiring_url).and_return('http://natashatherobot.com')
      @transaction.save!
      ActionMailer::Base.deliveries.first.to.should == [@transaction.email]
      ActionMailer::Base.deliveries.last.to.should == [@product.user.email]
    end
  end
end
