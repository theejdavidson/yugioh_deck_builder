class AddRaceAndAttributeToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :race, :string
    add_column :cards, :attribute, :string
  end
end
