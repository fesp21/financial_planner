class CategoriesController < ApplicationController
	before_filter :signed_in_user

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			flash[:success] = "Category successfully added."
			redirect_to new_category_path
		else
			render 'new'
		end
	end
end
