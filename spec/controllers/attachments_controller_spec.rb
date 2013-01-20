require 'spec_helper'

describe AttachmentsController do

  describe "show" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      FactoryGirl.create :attachment
    end
    context "when tinsale is the the HTTP Referrer" do
      before do
        @request.env["HTTP_REFERER"] = root_url
      end
      it "sends the attachment" do
        Attachment.any_instance.stub_chain(:item, :expiring_url).and_return('app/assets/images/stars0.png')
        URI.stub(:parse).and_return('app/assets/images/stars0.png')
        File.any_instance.stub(:content_type).and_return('png')
        controller.should_receive(:send_data).and_return{controller.render :nothing => true}
        get 'show', id: Attachment.last
      end
    end
    context "when tinysale is not the HTTP Referrer" do
      it "does not send the attachment" do
        controller.should_receive(:send_data).never
        get 'show', id: Attachment.last
        response.should redirect_to root_path
      end
    end
  end

end
