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

    def update
        byebug
    end

    def test_hand
        @hand = []
        @deck = Deck.find(params[:id])
        @cards = @deck.cards
        5.times do 
            sample = @cards.sample
            @hand << sample
            @cards = @cards - [sample] 
        end
        byebug
        p @hand
    end

    private

    def deck_params
        params.require(:deck).permit(:name)
    end

end