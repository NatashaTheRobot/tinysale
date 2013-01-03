# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  title       :string(255)
#  description :text
#  permalink   :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'spec_helper'

describe Product do

  it { should belong_to :user }
  it { should have_many :attachments }
  it { should have_many :images }
  it { should validate_presence_of :title }
  it { should validate_presence_of :description }
  it { should accept_nested_attributes_for :attachments }
  it { should accept_nested_attributes_for :images }

  describe "#generate_permalink" do
    before do
      @product = FactoryGirl.build :product
      Product.any_instance.stub(:save_attached_files).and_return(true)
      @product.save!
    end
    context "when a product with a new title is first created" do
      it "generates the correct permalink" do
        @product.permalink.should eq 'my-book'
      end
    end
    context "when a product from another user with a similar title is created" do
      before do
        @user2 = FactoryGirl.create :another_user
        @user3 = FactoryGirl.create :another_user, email: "yetanotherone@test.com"
      end
      context "when a product with an existing title is created" do
        it "increments the permalink" do
          product2 = FactoryGirl.create :product, user: @user2
          product2.permalink.should eq 'my-book-1'
          product3 = FactoryGirl.create :product, user: @user3
          product3.permalink.should eq 'my-book-2'
        end
      end
      context "when a product with a similar title is created" do
        it "does not increment the permalink and escapes weird characters" do
          product2 = FactoryGirl.create :product, title: "its my book!!!!", user: @user2
          product2.permalink.should eq 'its-my-book'
          product3 = FactoryGirl.create :product, title: "my book is the best & greatest", user: @user3
          product3.permalink.should eq 'my-book-is-the-best-greatest'
        end
      end
    end
  end

end
