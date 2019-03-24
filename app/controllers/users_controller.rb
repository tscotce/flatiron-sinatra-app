class UsersController < ApplicationController
  get '/login' do
    if logged_in?
      redirect to "events/index"
    else erb :"users/login"
    end
  end

  post '/login' do
    @user = User.find_by(username: params["username"])
    session[:id] = @user.id
    redirect to "events/show"
  end
  
  get '/signup' do
    if logged_in?
      redirect to "events/index"
    else erb :"users/signup"
    end
  end

  post '/signup' do
    if params[:first_name].present? && params[:last_name].present? && params[:username].present? && params[:email].present? && params[:password].present?
      @user = User.create(first_name: params[:first_name], last_name: params[:last_name], username: params[:username], email: params[:email], password: params[:password])
      session[:id] = @user.id
      redirect to "events/index"
    else redirect to "users/signup"
    end
  end


end
