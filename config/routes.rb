Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy, :comments] do
    resources :comments, only: :create 
    # コメントを保存するときにプロトタイプの情報が必要だから
  end
# ルーティグはリクエストに対してどのコントローラーのなんのアクションを行なっているところか
resources :users, only: :show
end