class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :charge, :download_sample]
  before_filter :find_product, only: [:show, :edit, :update, :destroy]

  load_and_authorize_resource

  # GET /sale
  def index
    @products = Product.all
    render :index
  end

  # GET /sale/:permalink
  def show
    @author = @product.user
    @comments = @product.comment_threads.includes(:user, :lead).order('created_at DESC')
    @lead = Lead.new
    @comment = @lead.comments.build
    render :show
  end

  # GET /sale/new
  def new
    @product = Product.new
    @product.attachments.build
    @product.images.build
    render :new
  end

  # GET /sale/:permalink/edit
  def edit

  end

  # POST /sale
  def create
    @product = Product.new(params[:product])
    @product.user = current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
      else
        @product.attachments.build unless @product.attachments.present?
        @product.images.build unless @product.images.present?
        format.html { render action: "new" }
      end
    end
  end

  # PUT /sale/:permalink
  def update

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /sale/:permalink
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def charge
    product = Product.includes(:attachments).find(params[:id])

    amount = product.price_in_cents
    Stripe.api_key = product.user.payment.access_token
    Stripe::Charge.create(
        :amount      => amount,
        :card        => params[:stripeToken],
        :description =>  "Tinysale Charge",
        :currency    => 'usd'
    )

    #error Stripe::CardError do
    #  "something went wrong!!!"
    #end

    # on success
    redirect_to attachment_path(product.attachments.first)
  end

  def download_sample
    @product = Product.find_by_permalink!(params[:permalink])
    io = open(URI.parse(@product.sample.expiring_url(10)))
    send_data io.read, type: io.content_type, filename: @product.sample_file_name
  end

  private

  def find_product
    @product ||= Product.includes(:attachments, :images, :user, :comment_threads).find_by_permalink!(params[:id])
  end
end
