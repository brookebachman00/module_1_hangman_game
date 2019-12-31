class AddInputs < ActiveRecord::Migration[5.0]
    player1 = Player.create(name: "AAAAA")
    player2 = Player.create(name: "BBBBB")
    player3 = Player.create(name: "CCCCC")
    player4 = Player.create(name: "DDDDD")
    player5 = Player.create(name: "EEEEE")

    # word1 = Word.create(words: "drive")
    # word2 = Word.create(words: "money")
    # word3 = Word.create(words: "")
    # word4 = Word.create(words: "")
    # word5 = Word.create(words: "")

    arr = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "commit", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
    arr.each do |ele|
        word = Word.create(words: ele)
    end
end