player1 = Player.create(name: "AAAAA")
player2 = Player.create(name: "BBBBB")
player3 = Player.create(name: "CCCCC")
player4 = Player.create(name: "DDDDD")
player5 = Player.create(name: "EEEEE")
 
arr = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "comes", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud", "smile", "sadly", "dizzy", "junky", "quick", "juicy", "field", "unzip", "japan", "kicky", "amaze", "check", "major", "joyed", "unfix", "zebra"]
arr.each do |ele|
    word = Word.create(word: ele)
end
word = Word.create(word: "fixes")