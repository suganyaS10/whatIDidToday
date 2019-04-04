class CommentsController < ApplicationController
	before_action :set_params, except: [:index, :new, :add_comments]
	skip_before_action :verify_authenticity_token, only: [:add_comments]


	def index
		@comments = Comment.all
	end

	def new
		@comment = Comment.new
	end

	def add_comments
		@comment_resp = Comment.build_comments_hash(JSON.parse(params[:comment].to_s), current_user)

		respond_to do |format|
      format.js       
    end
	end

	private

	def set_params
		@comment_params = params.require(:comment).permit(:description, :task_id)
	end
end
