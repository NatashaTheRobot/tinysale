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
      @comments = reviews
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

  describe "#product_url" do
    it "returns the product link" do
      product_url.should == "http://test.host/sale/my-book"
    end
  end

  describe "#num_ratings" do
    before do
      @comments = reviews
    end
    it "returns the number of ratings for a given product" do
      num_ratings.should == 2
    end
    context "when there are no ratings for a given product" do
      it "returns 0" do
        @comments = []
        num_ratings.should == 0
      end
    end
  end

  private
  def reviews
    review1 = FactoryGirl.build :comment, rating: 4, subtype: 'review', commentable: @product
    review2 = FactoryGirl.build :comment, rating: 3, subtype: 'review', commentable: @product
    [review1, review2]
  end
end