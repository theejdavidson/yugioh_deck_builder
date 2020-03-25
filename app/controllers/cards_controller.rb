class CardsController < ApplicationController
    def index
        @cards = Card.all.limit(100)
    end

    def show
        @card = find_card
    end

    def create
        byebug
    end

    def filter
        @card = Card.new
    end
    
    private

    def find_card
        @card = Card.find_by(id: params[:id])
    end
end