class SessionsController < ApplicationController
    get '/signup' do
      redirect_if_logged_in
      erb :signup
    end

    get '/login' do
      redirect_if_logged_in
      erb :login
    end

    post '/login' do
    @user = User.find_by(user_name: params[:user_name])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id # actually logging the user in
      redirect "users/#{@user.id}"
    else
      flash[:error] = "Something went wrong. Please try again."
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

    get '/*' do
      "404 not found"
    end
end