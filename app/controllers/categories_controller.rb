class CategoriesController < ApplicationController
  before_filter :signed_in_user

  def new
    #todo: allow nil budget
  	@category = Category.new(name: "", budget: "")
  end

  def create
  	@category = Category.new(params[:category])
  	if @category.save
  		flash[:success] = "Category successfully added."
  		@category = Category.new
  	end
  	render 'new'
  end
end
