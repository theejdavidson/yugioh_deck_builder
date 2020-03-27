class DecksController < ApplicationController
    before_action :authorized, only: [:index, :new, :show, :create]

    def index
        @user = current_user
        @decks = @user.decks
    end

    def show
        @deck = Deck.find(params[:id])
        @user = current_user
        @deck_cards = DeckCard.all.select { |dc| dc.deck_id == @deck.id }
        @logged_in = logged_in?
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

    def friends_deck
        
    end

    def test_hand

        @hand = []
        @deck = Deck.find(params[:id])

        if @deck.cards.count > 5
            @cards = @deck.cards.map {|c| c}
            5.times do 
                sample = @cards.sample
                @hand << sample
                @cards.delete_at(@cards.index(sample))
            end
            @mons = []
            @traps = []
            @spells = []
            @hand.each do |card|
                if card.card_type.include?("Monster")
                    @mons << card
                elsif card.card_type.include?("Spell")
                    @spells << card
                else 
                    @traps << card
                end
            end
            render :test
        else
            redirect_to decks_path
        end
        
    end

    private

    def deck_params
        params.require(:deck).permit(:name)
    end

end