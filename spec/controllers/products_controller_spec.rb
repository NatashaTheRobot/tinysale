require 'spec_helper'

describe ProductsController do

  describe "index" do
    before do
      get :index
    end
    it "returns a success response" do
      response.should be_success
    end
    it "renders the index page successfully" do
      response.should render_template "index"
    end
  end

  describe "show" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      get :show, id: @product.permalink
    end
    it "returns a success response" do
      response.should be_success
    end
    it "renders the show page successfully" do
      response.should render_template "show"
    end
  end

  describe "new" do
    before do
      sign_in FactoryGirl.create :user
      get :new
    end
    it "returns a success response" do
      response.should be_success
    end
    it "renders the new page successfully" do
      response.should render_template "new"
    end
  end

  describe "create" do
    before do
      sign_in FactoryGirl.create :user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = { title: "My Book",
                   description: "This is the best book you'll ever read",
                   price_in_cents: 100,
                   images_attributes: [cover: fixture_file_upload('/files/rails.png', 'image/png')],
                   attachments_attributes: [item: fixture_file_upload('/files/rails.png', 'image/png')]
                 }
    end
    it "successfully creates the product" do
      post :create, product: @product
      response.should redirect_to "http://test.host/sale/my-book"
    end
    context "when the product is not saved" do
      it "takes the user back to the product form" do
        Product.any_instance.stub(:save!).and_return(false)
        post :create, product: @product
        response.should render_template :new
      end
    end
  end

  describe "edit" do
    before do
      user = FactoryGirl.create :user
      sign_in user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product, user: user
      get :edit, id: @product.permalink
    end
    it "returns a success response" do
      response.should be_success
    end
    it "renders the edit page successfully" do
      response.should render_template "edit"
    end
    context "when a user is unauthorized" do
      it "rescues from CanCan::AccessDenied" do
        controller.stub(:authorize!) { raise CanCan::AccessDenied}
        get :edit, id: @product.permalink
        response.should redirect_to "/"
        flash[:alert] == "You do not have the necessary roles to access this page"
      end
    end
  end

  describe "update" do
    before do
      user = FactoryGirl.create :user
      sign_in user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product, user: user
    end
    it "redirects to the product page when it successfully updates the product" do
      Product.any_instance.stub(:update_attributes).and_return(true)
      put :update, id: @product.permalink, product: { title: "my other book" }
      response.should redirect_to @product
    end
    it "renders the edit action when the product is not successfully updated" do
      Product.any_instance.stub(:update_attributes).and_return(false)
      put :update, id: @product.permalink
      response.should render_template :edit
    end
  end

  describe "destroy" do
    before do
      user = FactoryGirl.create :user
      sign_in user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product, user: user
    end
    it "successfully deletes the product" do
      Attachment.any_instance.stub(:prepare_for_destroy).and_return(true)
      expect {
        delete :destroy, id: @product.permalink
      }.to change(Product, :count).by(-1)
    end
  end

  describe "charge" do
    before do
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product, attachments: [(FactoryGirl.create :attachment)]
      User.any_instance.stub_chain(:payment, :access_token).and_return(123)
      Stripe::Charge.stub(:create).and_return(true)
      Transaction.stub(:create).and_return(true)
    end
    context "when the charge is successful" do
      it "downloads the attachment" do
        get 'charge', id: @product.id
        response.should redirect_to attachment_path(Attachment.last)
      end
    end
  end

  describe "download_sample" do
    before do
      sign_in FactoryGirl.create :user
      Attachment.any_instance.stub(:save_attached_files).and_return(true)
      @product = FactoryGirl.create :product
      Product.any_instance.stub_chain(:sample, :expiring_url).and_return('app/assets/images/product/stars1.png')
      URI.stub(:parse).and_return('app/assets/images/product/stars1.png')
      File.any_instance.stub(:content_type).and_return('png')
    end
    it "downloads the product attachment" do
      controller.should_receive(:send_data).and_return{controller.render :nothing => true}
      get :download_sample, permalink: @product.permalink
    end
  end

end
