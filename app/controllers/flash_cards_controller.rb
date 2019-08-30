class FlashCardsController < ApplicationController
    get '/flash_cards' do
        @flash_cards = FlashCard.all
        erb :'flash_cards/index'
    end

    get '/flash_cards/new' do
        puts flash
        erb :'flash_cards/new'
    end

    post '/flash_cards' do
        if params[:english] != "" && params[:translation] != "" 
            @flash_card = FlashCard.create(params)
            @flash_card.user = User.first
             User.first.flash_cards << @flash_card #this will be updated after we build out sign up / login functionality 
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
        erb :'flash_cards/show'
    end

    get '/flash_cards/:id/edit' do
        @flash_card = FlashCard.find_by_id(params[:id])
        erb :'flash_cards/edit'
    end

    patch '/flash_cards/:id' do
    end

    delete '/flash_card/:id' do
    end


end