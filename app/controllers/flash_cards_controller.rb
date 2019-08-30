class FlashCardsController < ApplicationController
    get '/flash_cards' do
        @flash_cards = FlashCard.all
        erb :'flash_cards/index'
    end

    get '/flash_cards/new' do
        if logged_in?
        erb :'flash_cards/new'
        else 
            redirect '/login'
        end
    end

    post '/flash_cards' do
        if params[:english] != "" && params[:translation] != "" && logged_in?
            @flash_card = FlashCard.create(params)
            @user = User.find_by_id(session[:user_id])
            @flash_card.user = @user
            @user.flash_cards << @flash_card #this will be updated after we build out sign up / login functionality 
            flash[:success] = "Flash Card Created!" if @flash_card.id
        else
            #just messing around - this could be avoided entirely by setting input = required
            flash[:error] = "Fill out the dang thing!"
        end
        redirect '/flash_cards/new'
    end

    get '/flash_cards/:id' do
        @flash_card = FlashCard.find_by_id(params[:id])
        @next_flash_card = FlashCard.where("id > ?", @flash_card.id).first
        if @flash_card {
            erb :'flash_cards/show'
        } else {
            erb :'404'
        }
    end

    get '/flash_cards/:id/edit' do
        @flash_card = FlashCard.find_by_id(params[:id])
        erb :'flash_cards/edit'
    end

    patch '/flash_cards/:id' do
    end

    delete '/flash_card/:id' do
    end

    get '/*' do
        "404 not found"
    end


end