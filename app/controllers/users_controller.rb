class UsersController < ApplicationController
  before_filter :signed_in_user

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
  		flash[:success] = "User successfully added."
  		@user = User.new
    end
  	render 'new'
  end
end
