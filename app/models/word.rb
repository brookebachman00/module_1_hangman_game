class Word < ActiveRecord::Base
    has_many :players, through: :playerwords
  end