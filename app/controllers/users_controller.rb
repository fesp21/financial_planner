class UsersController < ApplicationController
  before_filter :signed_in_user

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		sign_in @user
  		flash[:success] = "User successfully added."
  		redirect_to root_path
  	else
  		render 'new'
  	end
  end
end
