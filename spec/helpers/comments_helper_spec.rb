require 'spec_helper'

include ApplicationHelper

describe CommentsHelper do

  describe "#author_image" do
    context "when signed in user created the comment" do
      before do
        @comment = FactoryGirl.create :comment, user: FactoryGirl.create(:user, email: 'nmurashev@gmail.com')
      end
      it "generates a user image" do
        author_image(@comment).should == "<img class=\"avatar\" height=\"120\" src=\"https://secure.gravatar.com/avatar/ef80d15dc032d1c0adf9547c5dd333b6?d=https://s3.amazonaws.com/tinysale/mrdefault.png\" width=\"120\" />"
      end
    end
    context "when a lead created the comment" do
      before do
        @comment = FactoryGirl.create :comment, lead: FactoryGirl.create(:lead)
      end
      it "generates a user image" do
        author_image(@comment).should == "<img alt=\"user image\" class=\"avatar\" height=\"120\" src=\"https://secure.gravatar.com/avatar/8d1c6b2a9f388249e5dde040ed5f7178?d=https://s3.amazonaws.com/tinysale/mrdefault.png\" width=\"120\" />"
      end
    end
  end

  describe "#author_name" do
    context "when signed in user created the comment" do
      before do
        @user = FactoryGirl.create(:user)
        @comment = FactoryGirl.create :comment, user: @user
      end
      it "returns the user's username" do
        author_name(@comment).should == @user.username
      end
    end
    context "when a lead created the comment" do
      before do
        @comment = FactoryGirl.create :comment, lead: FactoryGirl.create(:lead, email: 'nmurashev@gmail.com')
      end
      it "gets the user's name from gravatar" do
        author_name(@comment).should == 'natasham25'
      end
    end
  end

end
