Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

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
