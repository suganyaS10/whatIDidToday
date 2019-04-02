Rails.application.routes.draw do
	root to: 'tasks#index'
	
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   resources :users_admin, :controller => 'users'

   resources :tasks
   resources :likes
   post 'likes/like_post',  to: 'likes#like_post'

   resources :comments
   get 'comments/add_comments', to: 'comments#add_comments'

end
