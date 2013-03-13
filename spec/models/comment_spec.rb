require 'spec_helper'

describe Comment do

  it { should validate_presence_of :title }
  it { should ensure_length_of(:title).is_at_most(140) }
  it { should validate_presence_of :body }
  it { should belong_to :commentable }

  describe "#has_children?" do
    before do
      @comment = FactoryGirl.create :comment, user: (FactoryGirl.build :user)
    end
    context "when there are no child comments" do
      it "returns false" do
        @comment.has_children?.should be_false
      end
    end
    context "when there are child comments" do
      it "returns true" do
        another_comment = FactoryGirl.create :comment, user: (FactoryGirl.build :user)
        another_comment.move_to_child_of(@comment)
        @comment.has_children?.should be_true
      end
    end
  end

  describe ".find_commentable" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @comment = FactoryGirl.create :comment, user: (FactoryGirl.build :user), commentable: @product
    end
    it "finds the correct commentable object" do
      Comment.find_commentable("Product", @product.id).should == @product
    end
  end

end