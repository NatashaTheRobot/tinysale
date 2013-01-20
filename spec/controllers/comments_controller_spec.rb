require 'spec_helper'

describe CommentsController do
  describe "#create" do
    before do
      sign_in FactoryGirl.create :user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @comment = { title: "new comment",
                   body: "a comment",
                   commentable_type: "Product",
                   commentable_id: @product.id }
    end
    context "when the comment is not spam" do
      before do
        Comment.any_instance.stub(:spam?).and_return(false)
      end
      it "successfully creates a comment" do
        post 'create', comment: @comment, score: 3.5, format: :json
        new_comment = JSON.parse(response.body)
        new_comment["title"].should == "new comment"
        response.status.should == 200
      end
      context "when the comment is missing required fields" do
        before do
          @comment[:title] = nil
        end
        it "fails to create the comment" do
          post 'create', comment: @comment, format: :json
          response.status.should == 422
        end
      end
    end
  end
end
