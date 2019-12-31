require 'pry'
require_relative './Hangman.rb'
require_relative '../../config/environment'

# require_relative './Word.rb'


class HangmanGame 

    attr_accessor :username
    attr_reader :secret_word, :alpha, :random_word

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        @secret_word = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "comes", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
        @dashes = ["-","-","-","-","-"]
        @attempts = 0
        # @random_word = @secret_word.sample.split("")
        # binding.pry
        random = Word.all.sample.word
        @random_word = random.split("")
        #puts "#{@random_word}" this is for testing purposes
        @wrong_guesses = []
        @guessed_letters = []
        @count = 0
    end

    def start
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "/ᐠ｡ꞈ｡ᐟ\\ Welcome to Hangman! /ᐠ｡ꞈ｡ᐟ\\ " 
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "Where you have to guess the Secret word by putting in letters before the man gets hung!"

            puts "********************************"
            puts 'Enter a username:'
            @username = gets.chomp
  
            puts "********************************"

            puts "            "
            puts "Here's the word:"
            puts "☟ ☟ ☟ ☟ ☟"
            puts "    "
            puts @dashes.join(" ")
            
            puts "==============================="

            puts "Start by guessing the word with one letter at a time and click enter"
            guessing_letters

    end

    def guessing_letters

        while @attempts < 10 do
            @attempts += 1
            letter = gets.chomp.downcase
            if !@alpha.include?(letter)
                puts "#{letter} is not valid!"
            else 
                if letter.length > 1
                    puts "please only enter one letter in the alphabet"
                else 
                    if @guessed_letters.include?(letter)
                        puts "#{letter.upcase} has already been guessed!"
                    else
                        @guessed_letters << letter
                        if @random_word.include?(letter)
                            @random_word.each.with_index do |char, index|
                                if char == letter
                                     @dashes[index] = char
                                end
                            end
                        else
                            wrong_guess(letter) #counter dependent on hangman
                        end
                    
                    end
                end
            end
            puts "#{@dashes} "
            if !@dashes.include?("-")
                puts "You Won Hangman!"
                puts "/ᐠ｡ꞈ｡ᐟ\"
                puts "#{@dashes}"
                break
                
            end
        end
    end

    def wrong_guess(letter)
        @wrong_guesses << letter
        puts "Wrong Guess!"
        puts "#{@wrong_guesses}"
        puts Hangman.shape[@count]
        @count += 1
        if @count >= 7
            puts "You lose"
            play_again
        end
    end

    def play_again
        puts "Please type 'yes' to play again or anything else to exit the game"
        word = gets.chomp.to_s.downcase
        if word == 'yes'
            hang1 = HangmanGame.new
            hang1.start
            game = hang1.guessing_letters
        else puts "Bye, thank you for playing! Have a great day :)"
            abort
        end
    end
end


hang = HangmanGame.new
hang.start
game = hang.guessing_letters
hang.play_again
# puts #do you want to start again
# hang = HangmanGame.new
# hang.start
# game = hang.guessing_letters
