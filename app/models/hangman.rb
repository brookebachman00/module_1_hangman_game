#A class that holds the hangman in stages
class Hangman
    @@shape = ["
+---+
    |   |
        |
        |
        |
        |
  ========= ","
 
    +---+
    |   |
    O   |
        |
        |
        |
  ========= ","
    +---+
    |   |
    O   |
    |   |
        |
        |
  ========= ","
    +---+
    |   |
    O   |
   /|   |
        |
        |
  ========= ","
    +---+
    |   |
    O   |
   /|\\  |
        |
        |
  ========= ","
    +---+
    |   |
    O   |
   /|\\  |
   /    |
        |
  ========= ","
    +---+
    |   |
    O   |
   /|\\  |
   / \\  |
        |
  "]

    def self.shape
        @@shape
    end
end

