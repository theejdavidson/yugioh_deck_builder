class DecksController < ApplicationController
    before_action :authorized, only: [:index, :new, :show, :create]

    def index
        @user = current_user
        @decks = @user.decks
    end

    def show
        @deck = Deck.find(params[:id])
    end

    def new
        @deck = Deck.new
    end

    def create 
        @deck = Deck.new(deck_params)
        @deck.user_id = current_user.id
        @deck.save
        redirect_to deck_path(@deck)
    end

    private

    def deck_params
        params.require(:deck).permit(:name)
    end

end