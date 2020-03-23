class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.integer :attack
      t.integer :defense
      t.string :img_url
      t.string :card_type
      t.integer :level
      t.text :description
      t.string :name

      t.timestamps
    end
  end
end
