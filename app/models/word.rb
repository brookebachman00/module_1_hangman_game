# ActiveRecord doesn't exist

class Word < ActiveRecord::Base
  has_many :playerwords
  has_many :players, through: :playerwords
end
