require 'spec_helper'

describe PaymentsController do
  render_views

  before do
    sign_in FactoryGirl.create :user
  end

  describe "index" do
    before do
      get "index"
    end
    it "returns a success response" do
      response.should be_success
    end
    it "renders the index page successfully" do
      response.should render_template "index"
    end
  end

  describe "new" do
    before do
      get 'new', code: '123'
    end
    it "successfully creates the payment for the user" do
      response.should be_true
    end
  end
end
