Rails.application.routes.draw do
  devise_for :users

  	root 'home#index'
  	get 'order_detail/all_orders', to: 'order_detail#all_orders'

  	# get 'users/sign_out', to: 'devise/sessions#new'


	resources :admin, only: [:index]
	namespace :admin do
		resources :users
		resources :products do
			member do
				get :destroy_image
			end
		end
	end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	
end
