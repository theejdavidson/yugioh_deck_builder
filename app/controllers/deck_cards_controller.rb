class DeckCardsController < ApplicationController
    def create
        DeckCard.create(deck_card_params)
        @deck = Deck.find(params[:deck_card][:deck_id])
        redirect_to deck_path(@deck)
    end

    def destroy
        @dc  = DeckCard.find(params[:id])
        @deck = Deck.find_by(id: @dc.deck_id)
        @dc.destroy
        redirect_to deck_path(@deck)
    end

    private

    def deck_card_params
        params.require(:deck_card).permit(:deck_id, :card_id)
    end
end