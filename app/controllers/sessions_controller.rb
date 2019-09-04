class SessionsController < ApplicationController
    get '/signup' do
    # redirect_if_logged_in
    # erb (render) a view
        erb :signup
    end
    
    get '/*' do
        "404 not found"
    end
end