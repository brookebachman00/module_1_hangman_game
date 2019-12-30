class Player < ActiveRecord::Base
    has_many :words, through: :playerwords
end