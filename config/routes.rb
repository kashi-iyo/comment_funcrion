Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'posts#index'

  resources :users, only: [:show, :edit]
  resources :posts  do
    resources :comments, only: [:create]
  end

  #タグの検索結果表示
  resources :post_tags do
    get 'posts', to: 'posts#search'
  end
end
