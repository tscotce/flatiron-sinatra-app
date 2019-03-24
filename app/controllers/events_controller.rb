class EventsController < ApplicationController
  get '/events' do
    if logged_in?
      erb :"events/index"
    else redirect to :"/login"
    end
  end
end
