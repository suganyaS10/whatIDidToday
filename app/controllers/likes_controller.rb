class LikesController < ApplicationController
	before_action :set_params
	skip_before_action :verify_authenticity_token, only: [:like_post]

	def like_post
		response_json = Like.like_post(@like_params)	
		render :json => response_json.to_json
	end

	private

	def set_params
		@like_params = params.require(:like).permit(:task_id, :user_id)
	end
end
