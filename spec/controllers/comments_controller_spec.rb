require 'spec_helper'

describe CommentsController do
  describe "#create" do
    before do
      sign_in FactoryGirl.create :user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @comment = { title: "new comment", body: "a comment", c_type: "Product" }
    end
    it "successfully creates a comment" do
      Comment.any_instance.stub(:spam?).and_return(false)
      post 'create', comment: @comment, rating: { @product.id => "3.5"}
      Comment.last.title.should == "new comment"
      response.should redirect_to @product
    end
  end
end
