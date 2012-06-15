class GoalsController < ApplicationController
	before_filter :signed_in_user

	def create
		@goal = current_user.goals.build(params[:goal])
		@goal.purchased = false
		if @goal.save
			flash[:success] = "Don't flush those dreams just yet. New goal added."
			redirect_to goals_path
		else
			@goals = Goal.paginate(:page => params[:page])
			render 'index'
		end
	end

	def destroy
		@goal = Goal.find(params[:id]).destroy
		flash[:success] = "Flushed your dreams down the toilet."
		redirect_to goals_path
	end

	def index
		@goal = Goal.new
		@goals = Goal.paginate(:page => params[:page])
	end
end
