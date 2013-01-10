require 'spec_helper'

describe ProductsController do
  render_views

  describe "index" do
    it "renders the index page successfully" do
      get "index"
      response.should be_success
      response.should render_template "index"
    end
  end

  describe "show" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
    end
    it "renders the show page successfully" do
      get "show", permalink: @product.permalink
      response.should be_success
      response.should render_template "show"
    end
  end

  describe "new" do

  end

  describe "create" do

  end

  describe "edit" do

  end

  describe "update" do

  end

  describe "destroy" do

  end

end
