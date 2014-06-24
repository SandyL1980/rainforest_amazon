class ProductsController < ApplicationController
  before_filter :ensure_logged_in, :only => [:show]
  # before_action :ensure_logged_in, except: [:index, :show]
  
  def index
  	@products = Product.all
    @categories = Category.all
  end


  def show

    #I want to display the name of product associated
  	@product = Product.find(params[:id])
    @review = @product.reviews.build
    #@prod_category = @product[:category_id]

    # if current_user
    #   @review = @product.reviews.build
    # end
  
  end

  def new
  	@product = Product.new
    @categories = Category.all
  end


  def create 
  @product = current_user.products.build(product_params)
  # @product = Product.new(product_params)
  # @product.user_id = current_user.id

	  if @product.save
	  	redirect_to root_url, :notice => 'Your product was successfully created'
      redirect_to product_path(@product)
	  else
      #.now will make it appear right away wihout a redirect
      flash.now[:alert] = "OMG something wrong happened"
	  	render 'new'
	  end

  end

  

 
  def edit
  	@product = Product.find(params[:id])

  	if @product.update_attributes(product_params)
  		redirect_to product_path(@product),  :notice =>  'Your product was updated'
  	else
  		render 'edit'
  	end

    
  end


  def destroy
  	@product = Product.find(params[:id])
  	@product.destroy
  	redirect_to products_path

  end

  private
  def product_params
	params.require(:product).permit(:name, :description, :price_in_cents, :category_id)
  end
end
