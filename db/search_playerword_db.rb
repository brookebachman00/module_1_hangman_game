
    
    
    hangman_array.each do |h|
        puts h
    end

  def lose
    puts ""
    puts "Game Over!"
    puts "The special word was actually #{@random_word}"
  end