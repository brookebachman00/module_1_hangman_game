class Player < ActiveRecord::Base
    has_many :player_words
    has_many :words, through: :player_words
    # validates :name, presence: { message: "Please enter your name" }
end