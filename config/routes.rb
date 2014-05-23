Rails.application.routes.draw do
  devise_for :users
  root 'links#index'
  
  resources :links, :tags, :comments

  # get '/signup', to: 'users#new'
  # delete '/signout', to: 'sessions#destroy'
  # get'/signin', to: 'sessions#new'
end

#       Prefix Verb   URI Pattern                  Controller#Action
#         root GET    /                            links#index
#        links GET    /links(.:format)             links#index
#              POST   /links(.:format)             links#create
#     new_link GET    /links/new(.:format)         links#new
#    edit_link GET    /links/:id/edit(.:format)    links#edit
#         link GET    /links/:id(.:format)         links#show
#              PATCH  /links/:id(.:format)         links#update
#              PUT    /links/:id(.:format)         links#update
#              DELETE /links/:id(.:format)         links#destroy
#         tags GET    /tags(.:format)              tags#index
#              POST   /tags(.:format)              tags#create
#      new_tag GET    /tags/new(.:format)          tags#new
#     edit_tag GET    /tags/:id/edit(.:format)     tags#edit
#          tag GET    /tags/:id(.:format)          tags#show
#              PATCH  /tags/:id(.:format)          tags#update
#              PUT    /tags/:id(.:format)          tags#update
#              DELETE /tags/:id(.:format)          tags#destroy
#     comments GET    /comments(.:format)          comments#index
#              POST   /comments(.:format)          comments#create
#  new_comment GET    /comments/new(.:format)      comments#new
# edit_comment GET    /comments/:id/edit(.:format) comments#edit
#      comment GET    /comments/:id(.:format)      comments#show
#              PATCH  /comments/:id(.:format)      comments#update
#              PUT    /comments/:id(.:format)      comments#update
#              DELETE /comments/:id(.:format)      comments#destroy
