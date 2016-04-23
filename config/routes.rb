Rails.application.routes.draw do
  # Registration
  get  "register", to: "register#new"
  post "register", to: "register#create"

  # Authentication
  get "login", to: "login#new"
end
