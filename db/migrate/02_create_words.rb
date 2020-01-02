
class CreateWords < ActiveRecord::Migration[5.0]
    def change
     create_table :words do |t|
       t.string :word
       t.integer :score, default: 0
    end
   end
end