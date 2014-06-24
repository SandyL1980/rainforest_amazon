class CategoriesController < ApplicationController
  def index
  	@categories = Category.all
  end

  def new
   @category = Category.new
  end


  def create

  	@category = Category.new(category_params)

  	if @category.save 
  		redirect_to categories_path, :notice => "Category created"
  	else
  		render 'new'
  	end

  end

  def show
  	@category = Category.find(params[:id])
    @all_categories_products = @category.products

  end

  def edit
  	@category = Category.find(params[:id])

  	if @category.update_attributes(category_params)
  	  redirect_to category_path(@category), :notice => "Category updated"
  
  	else
  		render 'edit'
  	end

end

def destroy
  	@category = Category.find(params[:id])
  	@category.destroy
  	redirect_to categories_path
 end



  private
  def category_params
  	params.require(:category).permit(:name)
  end

end
