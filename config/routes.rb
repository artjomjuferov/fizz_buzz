Rails.application.routes.draw do
  get 'application/home'
  root 'application#home'

  put 'favorite/:number' => 'application#make_favorite', as: :make_favorite

end
