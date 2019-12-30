class CreatePlayers < ActiveRecord::Migration[5.0]
    def change
        create_table :players do |t|
            t.string :name
            t.integer :score
        end
    end
end