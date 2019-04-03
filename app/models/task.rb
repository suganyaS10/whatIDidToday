class Task < ApplicationRecord

	validates_presence_of :description, :creator
	validates_uniqueness_of :created_at, scope: :creator_id

	belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
	has_many :likes
	has_many :comments

	def self.build_task_hash(current_user)
		tasks_array = []
		tasks = Task.includes(:likes, :creator, :comments).all

		tasks.each do |task|
			task_hash = {}
			task_hash[:id] = task.id
			task_hash[:description] = task.description
			task_hash[:creator] = task.creator.name
			task_hash[:created_at] = task.calculated_posted_ago_time
			user_likes = task.likes.select {|like| like.user_id == current_user.id}
			task_hash[:likes_count] = task.likes.present? ? task.likes.count : 0
			task_hash[:comments_count] =  task.comments.present? ? task.comments.count : 0
      

			task_hash[:user_like_status] = user_likes.present? 
			task_hash[:comments] = task.comments
			tasks_array << task_hash
		end
		tasks_array
	end

	def calculated_posted_ago_time
		posted_ago_time = ''
		 posted_ago_hours = ((Time.now - self.created_at) / 1.hour).round
		 posted_ago_minutes = ((Time.now - self.created_at) / 1.minute).round

		 if posted_ago_hours > 0
		   posted_ago_time = posted_ago_hours.to_s + ' hours'
		 elsif posted_ago_minutes > 0
		   posted_ago_time = posted_ago_minutes.to_s + ' minutes'
		 else
		   posted_ago_seconds = ((Time.now - self.created_at) / 1.second).round
		   posted_ago_time = posted_ago_seconds.to_s + ' seconds'
		 end

		 posted_ago_time
	end
end
