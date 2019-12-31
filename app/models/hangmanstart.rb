class Hangman


    attr_accessor :username
    attr_reader :secretword, :alpha

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        @secretword = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "commit", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
        @attempts = 10
        @random_word = secretword.sample
        @correct_letters = []
        @wrong_guesses = []
        @guessed_letters = []
        @count = 0
    end


    def start
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "Welcome to Hangman!" 
            puts "Where you have to guess the Secret word by putting in letters before the man gets hung!"
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

            puts "*****************************"
            puts 'Enter a username:'
            @username = gets.chomp
  
            puts "*****************************"

            puts "Here's the word:"
            puts "_ _ _ _ _"
            puts "==============================="

            puts "Start by guessing the word with one letter at a time and click enter"
            guessing_letters

    end


    def guessing_letters
        
        letter = gets.chomp.to_s.downcase
        
        if @alpha.include?(letter)
            guessing_letters
        elsif puts "#{letter.upcase} is not valid!"
            guessing_letters

        if letter.length = 1
             guessing_letters
        elsif puts "please only enter one letter in the alphabet"
             guessing_letters

        if @guessed_letters.include?(letter)
           puts "#{letter.upcase} has already been guessed!"
        else
           @guessed_letters << letter

       
        if  @random_word.include?(letter)
          puts "#{letter.capitalize} was found! Well done! You are getting Closer!"
          @correct_letters << letter
          
        else puts "#{letter.capitalize} was not found! Keep trying!"
            @wrong_guesses << letter
            @count += 1
            Hangman.shape[@count]
            
              end
            end
           end
           guessing_letters
        end




end



hang = Hangman.new
hang.start
guessing_letters