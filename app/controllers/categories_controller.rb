class CategoriesController < ApplicationController
  before_filter :signed_in_user

  def new
  	@category = Category.new
  end

  def create
  	@category = Category.new(params[:category])
  	if @category.save
  		flash.now[:success] = "Category successfully added."
  		@category = Category.new
  	end
  	render 'new'
  end
end
