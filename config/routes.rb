Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'stream/enumerator'
  get 'stream/stream'
  get 'stream/proxy'
  get 'stream/early'
  get 'aws/signed-redirect'
end
