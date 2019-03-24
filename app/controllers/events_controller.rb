class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      erb :"events/index"
    else redirect to :"users/login"
    end
  end

  get '/events/new' do
    if logged_in?
      erb :"events/new"
    else redirect to :"users/login"
    end
  end


end
