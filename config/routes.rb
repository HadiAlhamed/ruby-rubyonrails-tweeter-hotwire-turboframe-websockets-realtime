Rails.application.routes.draw do
  devise_for :users

  # If logged in, go to Tweets
  authenticated :user do
    root to: "tweets#index", as: :authenticated_root
  end

  # If NOT logged in, go to Sign Up
  devise_scope :user do
    unauthenticated do
      root to: "devise/sessions#new", as: :unauthenticated_root
    end
  end

  resources :tweets do
    resources :likes
    resources :retweets
    resources :comments, module: :tweets
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
