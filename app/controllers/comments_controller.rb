class CommentsController < ApplicationController
	before_action :set_params, except: [:index, :new, :show, :edit, :list]


	def index
		@comments = Comment.all
	end

	def new
		@comment = Comment.new
	end

	def create
		@comment_params.merge!({user_id: current_user.id})
		@comment = Comment.create(@comment_params)

		if @comment.save
			flash[:success] = "Comment created Successfully"
		else
			flash[:error] = "Something went wrong. Try again"
		end
		
		respond_to do |format|
      format.js       
    end
	end

	def add_comments
		comments = Comment.where(task_id: params[:task_id])
	end

	private

	def set_params
		@comment_params = params.require(:comment).permit(:description, :task_id)
	end
end
