class TasksController < ApplicationController

	before_action :set_params, except: [:index, :new, :show, :edit]


	def index
		@tasks = Task.build_task_hash(current_user)
	end

	def new
		@task = Task.new
	end

	def create
		@task_params.merge!({creator_id: current_user.id})
		@task = Task.create(@task_params)

		if @task.save
			flash[:success] = "Task created Successfully"
			redirect_to tasks_path
		else
			flash[:error] = "Something went wrong. Try again"
			render :new
		end
	end

	private

	def set_params
		@task_params = params.require(:task).permit(:description)
	end
end
