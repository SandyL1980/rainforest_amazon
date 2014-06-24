class ReviewsController < ApplicationController
before_filter :load_product
before_filter :ensure_logged_in, :only => [:edit, :create, :show, :update, :destroy]
  .

  def show
  	@review = Review.find(params[:id])

    @Product = @review.products.build(review_params)
  end

  def create
  	@review = @product.reviews.build(review_params)
  	#I don't understant this line
  	@review.user_id = current_user.id

  	if @review.save
      redirect_to products_path, notice: 'Review created successfully'
    else
      flash.now[:alert] = "your comment failed to be created"
      render 'products/show'
    end

  end

  def destroy
  	@review = Review.find(params[:id])
  	@review.destroy
  end


  private
  def review_params
  	params.require(:review).permit(:name, :email, :comment, :product_id)

  end

  def load_product 
  	#I don't understant this line
  	@product = Product.find(params[:product_id])
  end
end
