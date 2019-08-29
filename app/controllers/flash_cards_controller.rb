class FlashCardsController < ApplicationController
    get '/flash_cards' do
        @flash_cards = FlashCard.all
        erb :'flash_cards/index'
    end

    get '/flash_cards/new' do
        erb :'flash_cards/new'
    end

    post '/flash_cards' do
        @flash_card = FlashCard.create(params)
        @flash_card.user = User.first
        User.first.flash_cards << @flash_card #this will be updated after we build out sign up / login functionality 
        @message = "Flash Card created!" if @flash_card.id
        erb :'/flash_cards/new'
    end
end