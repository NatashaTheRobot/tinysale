class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :charge]
  before_filter :find_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @products }
    end
  end

  # GET /products/:permalink
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.attachments.build
    @product.images.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @product }
    end
  end

  # GET /products/:permalink/edit
  def edit

  end

  # POST /products
  def create
    @product = Product.new(params[:product])
    @product.user = current_user

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render json: @product, status: :created, location: @product }
      else
        @product.attachments.build unless @product.attachments.present?
        @product.images.build unless @product.images.present?
        format.html { render action: "new" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /products/:permalink
  def update

    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/:permalink
  def destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  def charge
    product = Product.includes(:attachments).find(params[:id])

    amount = product.attachments.first.price_in_cents
    Stripe.api_key = STRIPE_API_KEY
    Stripe::Charge.create(
        :amount      => amount,
        :card        => params[:stripeToken],
        :description =>  "Tinysale Charge",
        :currency    => 'usd'
    )

    #error Stripe::CardError do
    #  "something went wrong!!!"
    #end

    redirect_to root_path
  end

  private

  def find_product
    @product ||= Product.includes(:attachments, :images).find_by_permalink!(params[:id])
  end
end
