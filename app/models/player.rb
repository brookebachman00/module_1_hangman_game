class Player < ActiveRecord::Base
    has_many :player_words
    has_many :words, through: :player_words
end