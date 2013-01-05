class ProductsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index, :charge, :download]
  before_filter :find_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  def index
    @products = Product.all
    render :index
  end

  # GET /products/:permalink
  def show
    @author = @product.user
    @comments = @product.comment_threads
    @comment = Comment.new
    render :show
  end

  # GET /products/new
  def new
    @product = Product.new
    @product.attachments.build
    @product.images.build
    render :new
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
    redirect_to download_path(id: product.attachments.first.id)
  end

  def download
    id = params[:id]
    attachment = Attachment.find(id)
    io = open(URI.parse(attachment.item.expiring_url(10)))
    send_data io.read, type: io.content_type, filename: attachment.item_file_name
  end

  private

  def find_product
    @product ||= Product.includes(:attachments, :images, :user).find_by_permalink!(params[:id])
  end
end
