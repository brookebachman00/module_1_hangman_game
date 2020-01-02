
class CreatePlayerWords < ActiveRecord::Migration[5.0]
    def change
        create_table :player_words do |t|
            t.belongs_to :player
            t.belongs_to :word
            # t.integer :player_id
            # t.integer :word_id
        end
    end
end