class Like < ApplicationRecord

	validates_presence_of :task, :user
	validates_uniqueness_of :task, scope: :user

	belongs_to :user
	belongs_to :task

	def self.like_post(like_params)
		like_obj = Like.includes(:task, :user).where(like_params)
		like = false		
		task_id = like_params[:task_id] if like_params[:task_id].present?
		if like_obj.present?
			if Like.destroy(like_obj.first.id)
				status = 200
			end
		else
			like_obj = Like.create(like_params)
			if like_obj.save 
				status = 200
			end
			like = true
		end

		like_objs = Like.where(task_id: task_id).all
		like_count = like_objs.count

		{status: status, like: like, like_count: like_count}
	end
end
