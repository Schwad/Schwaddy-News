Rails.application.routes.draw do

  root 'stories#index'
  resources :stories, only: :index
  namespace 'api' do
    namespace 'v1' do
      get 'list_stories', to: 'external#list_stories'
    end
  end
end
