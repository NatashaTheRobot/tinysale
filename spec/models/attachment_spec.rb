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
    end
  end
end
