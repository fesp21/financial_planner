class CategoriesController < ApplicationController
	before_filter :signed_in_user

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params[:category])
		if @category.save
			flash[:success] = "Category added."
			redirect_to new_category_path
		else
			render 'new'
		end
	end

	def destroy
		@category = Category.find(params[:id]).destroy
		flash[:success] = "Category deleted, you monster."
		redirect_to categories_path
	end

	def index
		@categories = Category.paginate(:page => params[:page])
	end
end
