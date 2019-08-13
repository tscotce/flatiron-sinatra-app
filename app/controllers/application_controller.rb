# require './config/environment'

class ApplicationController < Sinatra::Base

set :views, Proc.new { File.join(root, "../views/")}

configure do
  enable :sessions
  set :session_secret, "secret"
end

get '/' do
  erb :index
end


helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			@current_user ||= User.find(session[:id])
		end

    def logout!
      session.clear
    end
	end
end
