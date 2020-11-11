Rails.application.routes.draw do
  devise_for :users
  root to: 'ballot_boxes#top'
  resources :ballot_boxes do
    resources :votes, only: [:create]
    resources :rooms, only: [:index, :destroy] do
      resources :discussions, only: [:create]
    end
  end
end
