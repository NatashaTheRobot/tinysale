require 'spec_helper'

describe AttachmentsController do

  describe "show" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      FactoryGirl.create :attachment
    end
    it "sends the attachment" do
      Attachment.any_instance.stub_chain(:item, :expiring_url).and_return('app/assets/images/star-half.png')
      URI.stub(:parse).and_return('app/assets/images/star-half.png')
      File.any_instance.stub(:content_type).and_return('png')
      controller.should_receive(:send_data).and_return{controller.render :nothing => true}
      get 'show', id: Attachment.last
    end
  end

end
