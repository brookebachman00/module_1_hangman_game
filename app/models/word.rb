class Word < ActiveRecord::Base
  has_many :player_words
  has_many :players, through: :player_words
end

