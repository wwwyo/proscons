Rails.application.routes.draw do
  devise_for :users
  root to: 'ballot_boxes#top'
  resources :ballot_boxes do
    resources :votes, only: [:create]
  end
end
