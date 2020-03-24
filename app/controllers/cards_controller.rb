class CardsController < ApplicationController
    def index
        @cards = Card.all.limit(100)
    end

    def show
        find_card
    end
    
    private

    def find_card
        @card = Card.find_by(id: params[:id])
    end
end