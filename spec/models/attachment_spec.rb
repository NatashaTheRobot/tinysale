# == Schema Information
#
# Table name: attachments
#
#  id                :integer          not null, primary key
#  status            :string(255)
#  price_in_cents    :integer
#  product_id        :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  item_file_name    :string(255)
#  item_content_type :string(255)
#  item_file_size    :integer
#  item_updated_at   :datetime
#

require 'spec_helper'

describe Attachment do
  it { should belong_to :product }
  it { should validate_presence_of :price_in_cents }
  it { should validate_format_of(:price_in_cents).with(500)}
  it { should validate_numericality_of(:price_in_cents)}
  it { should validate_attachment_presence :item }
  it { should validate_attachment_size :item }

  context "before create" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @attachment = FactoryGirl.create :attachment
    end
    describe "#set_status_to_active" do
      it "sets the status to active" do
        @attachment.status.should == :active
      end
      it "correctly coverts the price from dollars to cents" do
        @attachment.price_in_cents.should == 10000
      end
    end
  end
end
