require 'test_helper'

class DeckTest < ActiveSupport::TestCase
  test "should not save deck without name" do
    deck = Deck.new
    assert_not deck.save, "Saved the deck without a name"
  end
end
