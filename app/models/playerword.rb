class Playerwords < ActiveRecord::Base
    has_many :players
    has_many :words

end