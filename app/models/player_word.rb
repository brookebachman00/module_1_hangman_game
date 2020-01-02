class PlayerWord < ActiveRecord::Base
    belongs_to :player
    belongs_to :word
end