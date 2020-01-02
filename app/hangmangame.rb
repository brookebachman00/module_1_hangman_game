require 'pry'
require_relative './string'
require_relative '../config/environment'



class HangmanGame 

    attr_accessor :username
    attr_reader :alpha, :random_word

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        #@secret_word = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "comes", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
        @dashes = ["-","-","-","-","-"]
        @attempts = 0
        # random = Word.all.sample.word
        # @random_word = random.split("")
        # puts "#{@random_word}" #this is for testing purposes
        @wrong_guesses = []
        @guessed_letters = []
        @count = 0
        @guessed_count = 0
    end

    def random_word
        word_list = old_player
        random = Word.all.sample.word
        # binding.pry
        @random_word = random.split("")
        if word_list.length > 0
            while word_list.include?(@random_word.join("")) do
                @random_word = Word.all.sample.word.split("")
            end
        end
    end

    def start
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "/ᐠ｡ꞈ｡ᐟ\\ Welcome to Hangman! /ᐠ｡ꞈ｡ᐟ\\ ".blue
            puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
            puts "Where you have to guess the Secret word by putting in letters before the man gets hung!".blue

            puts "********************************"
            puts 'Enter a username:'.blue
            @username = gets.chomp
            # binding.pry
            enter_usermane
            # binding.pry
            random_word
            # puts @random_word
            # binding.pry
            puts "********************************"

            puts "            "
            puts "Here's the word:".blue
            puts "☟ ☟ ☟ ☟ ☟"
            puts "    "
            puts @dashes.join(" ")
            
            puts "==============================="
            puts "Start by guessing the word with one letter at a time and click enter, remember you have only 10 attempts to guess the word".blue
            guessing_letters
    end

#Check for player's name
    def enter_usermane
        while @username.length == 0 do
            puts "!!!!!!!!!!!!You need to enter a Username!!!!!!!!!!!!".red
            puts "   "
            puts 'Enter a username:'.blue
                @username = gets.chomp
        end
    end

#Check if the input given by player is a letter (check for alphabet and its length)
    def validation?(letter)
        if !@alpha.include?(letter)
            puts "#{letter} is not valid!".red
            return true
        elsif letter.length > 1
            puts "please only enter one letter in the alphabet".red
            return true
        end
        return false
    end

#Check if its already guessed by player
    def is_guessed?(letter)
        if @guessed_letters.include?(letter)
            puts "#{letter.upcase} has already been guessed!".red
            @guessed_count += 1
            return true
        else
            return false
        end
    end

#Check for the player's guessed letter (Has the player guessed it right or wrong)
    def right_guess(letter)
        @guessed_letters << letter
        if @random_word.include?(letter)    #if the player makes a right guess
            @random_word.each.with_index do |char, index|
                if char == letter
                    @dashes[index] = char
                end
            end
        else
            wrong_guess(letter)                #if the player makes a wrong guess
        end           
    end

    def guessing_letters
        while @attempts < 10 do  
            Player.last.words << Word.find_by(word: @random_word.join(""))
            letter = gets.chomp.downcase
            if !validation?(letter) && !is_guessed?(letter)
                right_guess(letter)
            end
            puts "#{@dashes} "
            if check_for_dashes?
                play_again
            else
                if @attempts < 9 
                    @attempts += 1
                else
                    puts "Better luck next time, " + Player.last.name + ".".red
                    play_again
                end
            end
        end
        # play_again
    end

#Check if the player guessed the secret word?
    def check_for_dashes?
        if !@dashes.include?("-")
            puts "#{@dashes.join("")}".upcase.bold.underline
            update_player
            puts "Good job ".green.bold + Player.last.name + ", You Won Hangman!".green.bold
            puts " Your total score is #{Player.last.score}".blue
            puts "/ᐠ｡ꞈ｡ᐟ\\"
            return true
        end
        return false
    end

    
#If the player makes a wrong guess
    def wrong_guess(letter)
        @wrong_guesses << letter
        puts "Wrong Guess!".red
        puts "#{@wrong_guesses}"
        puts Hangman.shape[@count].red          #Call for Hangman model
        @count += 1
        if @count >= 7
            puts "Better luck next time, ".magenta + Player.last.name
            play_again
        end
    end

#Check if the player wants to continue the game
    def play_again
        puts "Please type 'yes' to play again or enter another key to exit the game".blue
        word = gets.chomp.to_s.downcase
        if word == 'yes'
            hang1 = HangmanGame.new
            hang1.start
        else 
            puts "Bye, thank you for playing! Have a great day :)".cyan
            exit
        end
    end

#Total number of players
    def game_players
        Player.count
    end 

#Update word -> score
    def update_word
        # binging.pry
        word = Word.find_by(word: @random_word.join(""))
        if word.score == 0
            word.score += 10
            word.save
        end
    end

#Update Player -> score
    def update_player
        player = Player.last
        player.score += 10
        player.save
    end


#no word repeat
    def old_player
        words = []
        player = Player.find_by(name: @username)
        if player
            words_list = player.words
            words_list.select do |ele|
                words << ele.word
            end
        else
            Player.create(name: @username)
            words = []
        end
        words
    end
end



hang = HangmanGame.new
hang.start

#Players count
total = hang.game_players
#puts "Hangman players - #{total}"
