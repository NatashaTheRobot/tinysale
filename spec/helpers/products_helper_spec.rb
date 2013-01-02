require 'spec_helper'

describe ProductsHelper do
  before do
    @product = FactoryGirl.build :product
  end

  describe "file_type" do
    it "returns the correct file type" do
      file_type(@product).should == "PNG"
    end
  end

  describe "file_size" do
    it "returns the correct file size" do
      file_size(@product).should == 6
    end
  end

  describe "price_in_dollars" do
    it "returns a correctly formatted price in dollars" do
      price_in_dollars(@product).should == "$1.00"
    end
  end
end