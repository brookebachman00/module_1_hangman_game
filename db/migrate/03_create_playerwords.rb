
class CreatePlayerwords < ActiveRecord::Migration[5.0]
    def change
        create_table :playerwords do |t|
            t.string :player_id
            t.string :word_id
        end
    end
end