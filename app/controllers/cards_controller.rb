class CardsController < ApplicationController
    before_action :authorized
    
    def index
        @cards = Card.all.limit(100)
    end

    def new
    end

    def show
        @card = find_card
        @decks = Deck.where(user_id: current_user.id)
        @deck_card = DeckCard.new
    end

    def create
        @deck = Deck.find_by(id: params[:id])
    end

    def filter
        @card = Card.new
    end
    
    private

    def find_card
        @card = Card.find_by(id: params[:id])
    end
end