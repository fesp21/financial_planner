class CategoriesController < ApplicationController
	before_filter :signed_in_user

	def create
		@category = Category.new(params[:category])
		if @category.save
			flash[:success] = "Category added. Meow!"
			redirect_to categories_path
		else
			@categories = Category.paginate(:page => params[:page])
			render 'index'
		end
	end

	def destroy
		@category = Category.find(params[:id]).destroy
		flash[:success] = "Category exterminated, you monster."
		redirect_to categories_path
	end

	def index
		@categories = Category.paginate(:page => params[:page])
		@category = Category.new
	end

	def show
		@category = Category.find(params[:id])
		@debits = @category.debits.paginate(:page => params[:page])
	end
end
