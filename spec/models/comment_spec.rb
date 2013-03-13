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

  describe "#email_address" do
    context "when a user creates a comment" do
      before do
        Attachment.any_instance.stub(:save_attached_files).and_return(true)
        @user = FactoryGirl.build :user
        @comment = FactoryGirl.create :comment, user: @user, commentable: (FactoryGirl.create :product)
      end
      it "returns the correct email address" do
        @comment.email_address.should == @user.email
      end
    end
    context "when a lead creates a comment" do
      before do
        Attachment.any_instance.stub(:save_attached_files).and_return(true)
        @lead = FactoryGirl.create :lead
        @comment = FactoryGirl.create :comment, lead: @lead,user: nil, commentable: (FactoryGirl.create :product)
      end
      it "returns the correct email address" do
        @comment.email_address.should == @lead.email
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

  describe ".find_comments_by_user" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @user = FactoryGirl.build :user
      @comment = FactoryGirl.create :comment, user: @user, commentable: (FactoryGirl.create :product)
      @user2 = FactoryGirl.build :user
      @comment2 = FactoryGirl.create :comment, user: @user2, commentable: (FactoryGirl.create :product)
    end
    it "returns comments for the specified user" do
      Comment.find_comments_by_user(@user).should == [@comment]
      Comment.find_comments_by_user(@user2).should == [@comment2]
    end
  end

  describe ".find_comments_for_commentable" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      @comment = FactoryGirl.create :comment, commentable: @product, user: (FactoryGirl.build :user)
      @comment2 = FactoryGirl.create :comment, commentable: @product, user: (FactoryGirl.build :user)

      @product2 = FactoryGirl.create :product
      @comment3 = FactoryGirl.create :comment, commentable: @product2, user: (FactoryGirl.build :user)
    end
    it "returns all the comments for the specified product" do
      Comment.find_comments_for_commentable("Product", @product).should =~ [@comment, @comment2]
      Comment.find_comments_for_commentable("Product", @product2).should == [@comment3]
    end
  end
end