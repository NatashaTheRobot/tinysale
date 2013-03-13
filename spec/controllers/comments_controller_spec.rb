require 'spec_helper'

describe CommentsController do
  describe "#create" do
    before do
      sign_in FactoryGirl.create :user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @comment = { title: "new comment",
                   body: "a comment",
                   subtype: 'comment',
                   commentable_type: "Product",
                   commentable_id: @product.id }
    end
    context "when the comment is not spam" do
      before do
        Comment.any_instance.stub(:spam?).and_return(false)
      end
      it "successfully creates a comment" do
        post 'create', comment: @comment
        Comment.last.title.should == "new comment"
        response.status.should == 200
      end
    end
  end
end
