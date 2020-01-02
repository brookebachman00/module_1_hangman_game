class CreatePlayers < ActiveRecord::Migration[5.0]
    def change
        create_table :players do |t|
            t.string :name
            t.integer :score, default: 0
        end
    end
end