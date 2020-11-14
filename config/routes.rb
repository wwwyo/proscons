Rails.application.routes.draw do
  devise_for :users
  root to: 'ballot_boxes#top'
  resources :ballot_boxes do
    resources :votes, only: [:create, :update]
    resources :rooms, only: [:index, :destroy] do
      resources :discussions, only: [:create] do
        resources :likes, only: [:create, :destroy]
      end
    end
  end
end
