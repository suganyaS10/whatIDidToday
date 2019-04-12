namespace :seed do

  desc 'Import example Data'
  task sample: :environment do
    description = 'Recently I have written a book about Rake. 
    It’s called Rake Task Management Essentials. If you like this post’s content and
    nterested in Rake, if you would like to know more about this great tool you can buy
    it here'
   
    user = User.create!({:name => 'admin',:email => "admin123@gmail.com", 
     :password => "admin123", :password_confirmation => "admin123" })


    (0..5).each do |i|
    	task = Task.create({description: "sample_#{i} #{description}", creator_id: user.id})
    	if task.save
    		Rails.logger.info "Package Created"
    		puts "s"
    	else
    		puts "error"
    		Rails.logger.info "#{task.errors}"
    	end
    end

    like = Like.create({task_id: 1, user_id: 1})

    if like.save
        puts "liked"
    else
        puts "Like unsuccessful"
    end

    comment = Comment.create({task_id: 1, user_id: 1, description: 'This is awesome'})

    if comment.save
        puts 'comment saved'
    else
        puts 'comment unsuccessful'
    end
  end
end
