class FlashCardsController < ApplicationController
    get '/flash_cards' do
        @flash_cards = FlashCard.all
        erb :'flash_cards/index'
    end

    get '/flash_cards/new' do
        redirect_if_not_logged_in
        erb :'flash_cards/new'
    end

    post '/flash_cards' do
        redirect_if_not_logged_in
        if params[:english] != "" && params[:translation] != ""
            @flash_card = FlashCard.create(params)
            @user = User.find_by_id(session[:user_id])
            @flash_card.user = @user
            @user.flash_cards << @flash_card 
            flash[:success] = "Flash Card Created!" if @flash_card.id
        else
            #just messing around - this could be avoided entirely by setting input = required
            flash[:error] = "Fill this out!"
        end
            redirect '/flash_cards/new'
    end

    get '/flash_cards/:id' do
        @flash_card = FlashCard.find_by_id(params[:id])
        @next_flash_card = FlashCard.find_by("id > ?", @flash_card.id)
        if @flash_card && @flash_card.user_id == session[:user_id]
            erb :'flash_cards/show'
        else 
            puts 'not your flash card!'
            erb :'flash_cards/new'
        end
    end

    get '/flash_cards/:id/edit' do
        @flash_card = FlashCard.find_by_id(params[:id])
        erb :'flash_cards/edit'
    end

    patch '/flash_cards/:id' do
        redirect_if_not_logged_in
        @flash_card = FlashCard.find_by_id(params[:id])
        if can_edit?(@flash_card)
            @flash_card.update(english: params[:english], translation: params[:translation])
            redirect "/flash_cards/#{@flash_card.id}"
        else
            redirect "users/#{current_user.id}"
        end
    end

    delete '/flash_cards/:id' do
        redirect_if_not_logged_in
        @flash_card = FlashCard.find_by_id(params[:id])
        if can_edit?(@flash_card)
            @flash_card.destroy
        end
        redirect "users/#{current_user.id}"
    end
end