class UsersController < ApplicationController
    post '/users' do
      redirect_if_logged_in
      @user = User.new(params)
      # Using AR validation, calling User.new with invalid params will return with an error
      # Calling save will return true or false - @user.save returns false if the original User.new call above return
      # fails validation
      if @user.save
          #if the user is successfully saved, log them in and redirect
          session[:user_id] = @user.id
          redirect "/users/#{@user.id}"
        else
          #else flash an error and send them back to the signup page
          flash[:error] = "#{@user.errors.full_messages.to_sentence}"
          redirect '/signup'
        end
      end
    
      get '/users/:id' do
        @user = User.find_by(id: params[:id])
        if @user && @user.id == session[:user_id]
        @flash_card = FlashCard.find_by("user_id = #{params[:id]}")
        erb :'/users/show'
        else
          redirect '/logout'
        end
      end
end