class Comment < ApplicationRecord

	belongs_to :task
	belongs_to :user

	def self.build_comments_hash(comment_params, current_user)
		comment_params.merge!({user_id: current_user.id})
		comment = Comment.create(comment_params)
		comments_hash = {}
		comments_hash[:task_container_id] = "task-comments-container_#{comment_params['task_id']}"
		comments_hash[:comments] = Comment.where(task_id: comment_params["task_id"]).to_a
		comments_hash[:task_id] = comment_params["task_id"]
		comments_hash[:desc_id] = "desc_#{comment_params['task_id']}"
		comments_hash[:comments_count_id] = "comments_count_#{comment_params['task_id']}"
    comments_hash[:comments_count] = comments_hash[:comments].present? ? comments_hash[:comments].count : 0


		unless comment.save
			comments_hash[:error] = comment.errors
		end
		comments_hash
	end
end
