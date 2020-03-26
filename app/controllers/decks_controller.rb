class DecksController < ApplicationController
    before_action :authorized, only: [:index, :new, :show, :create]

    def index
        @user = current_user
        @decks = @user.decks
    end

    def show
        @deck = Deck.find(params[:id])
        @deck_cards = DeckCard.select { |dc| dc.deck_id == @deck.id }
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
        @cards = @deck.cards.map {|c| c}
        5.times do 
            sample = @cards.sample
            @hand << sample
            @cards.delete_at(@cards.index(sample))
        end
        render :test
    end

    private

    def deck_params
        params.require(:deck).permit(:name)
    end

end