class CreatePlayerwords< ActiveRecord::Migration[5.2]
    def change
        create_table: playerwords do |t|
            t.string :player
            t.string :word
        end
    end
end