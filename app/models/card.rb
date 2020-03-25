class Card < ApplicationRecord
    has_many :deck_cards
    has_many :decks, through: :deck_cards
    
    def self.races
        races = self.all.map {|card| card.race }
        races.uniq
    end

    def self.card_types
        card_types = self.all.map {|card| card.card_type }
        card_types.uniq
    end

    def self.attrs
        attrs = self.all.map {|card| card.attr }
        attrs.uniq
    end

    def self.levels
        levels = self.all.map {|card| card.level }
        levels.uniq
    end
end
