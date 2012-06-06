class UsersController < ApplicationController
	before_filter :signed_in_user

	def new
		@user = User.new
	end

	def create
		@user = User.new(params[:user])
		if @user.save
			flash[:success] = "User added. You have brought life into this world."
			redirect_to new_user_path
		else
			render 'new'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "So be it. User maliciously destroyed."
		redirect_to users_path
	end

	def index
		@users = User.paginate(page: params[:page])
	end
end
