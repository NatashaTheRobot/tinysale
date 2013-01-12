require 'spec_helper'

describe ProductsHelper do
  before do
    Attachment.any_instance.stub(:save_attached_files).and_return(true)
    @product = FactoryGirl.create :product
  end

  describe "#file_type" do
    it "returns the correct file type" do
      file_type.should == "PNG"
    end
  end

  describe "#file_size" do
    it "returns the correct file size" do
      file_size.should == 7
    end
  end

  describe "#price_in_dollars" do
    it "returns a correctly formatted price in dollars" do
      price_in_dollars.should == "$100.00"
    end
  end

  describe "#average_rating" do
    before do
      comment1 = FactoryGirl.build :comment, rating: 4, commentable: @product
      comment2 = FactoryGirl.build :comment, rating: 3, commentable: @product
      @comments = [comment1, comment2]
    end
    it "calculates the correct average rating" do
      average_rating.should == 3.5
    end
    context "when there are no comments" do
      it "returns 0 as the average rating" do
        @comments = []
        average_rating.should == 0
      end
    end
  end
end