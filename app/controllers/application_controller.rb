require './config/environment'

class ApplicationController < Sinatra::Base

set :views, Proc.new { File.join(root, "../views/")}

configure do
  enable :sessions
  set :session_secret, "secret"
end

get '/' do
  erb :index
end

get '/login' do
  if logged_in?
    redirect to "events/index"
  else erb: "users/login"
  end
end

helpers do
		def logged_in?
			!!session[:id]
		end

		def current_user
			User.find(session[:id])
		end
	end

end
