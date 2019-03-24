class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect to "events/index"
    else erb :"users/signup"
    end
  end


end
