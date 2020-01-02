require 'pry'
require_relative '../config/environment'

class HangmanGame 

    attr_accessor :username
    attr_reader :alpha, :random_word

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        #@secret_word = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "comes", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
        @dashes = ["-","-","-","-","-"]
        @attempts = 0
        random = Word.all.sample.word
        @random_word = random.split("")
        puts "#{@random_word}" #this is for testing purposes
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
            Player.create(name: @username)
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

#Check if the input given by player is a letter (check for alphabet and its length)
    def validation?(letter)
        if !@alpha.include?(letter)
            puts "#{letter} is not valid!"
            return true
        elsif letter.length > 1
            puts "please only enter one letter in the alphabet"
            return true
        end
        return false
    end

#Check if its already guessed by player
    def is_guessed?(letter)
        if @guessed_letters.include?(letter)
            puts "#{letter.upcase} has already been guessed!"
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
            letter = gets.chomp.downcase
            if !validation?(letter) && !is_guessed?(letter)
                right_guess(letter)
            end
            puts "#{@dashes} "
            if check_for_dashes?
                play_again
            else
                @attempts += 1
            end
        end
    end

#Check if the player guessed the secret word?
    def check_for_dashes?
        if !@dashes.include?("-")
            puts "#{@dashes.join("")}"
            update_player
            # update_word
            puts "Good job " + Player.last.name + ", You Won Hangman!"
            puts " Your score = #{Player.last.score}"
            puts "/ᐠ｡ꞈ｡ᐟ\\"
            return true
        end
        return false
    end

    # def guessing_letters

    #     while @attempts < 10 do
    #         @attempts += 1
    #         letter = gets.chomp.downcase
    #         if !@alpha.include?(letter)
    #             puts "#{letter} is not valid!"
    #         else 
    #             if letter.length > 1
    #                 puts "please only enter one letter in the alphabet"
    #             else 
    #                 if @guessed_letters.include?(letter)
    #                     puts "#{letter.upcase} has already been guessed!"
    #                 else
    #                     @guessed_letters << letter
    #                     if @random_word.include?(letter)
    #                         @random_word.each.with_index do |char, index|
    #                             if char == letter
    #                                  @dashes[index] = char
    #                             end
    #                         end
    #                     else
    #                         wrong_guess(letter) #counter dependent on hangman
    #                     end
                    
    #                 end
    #             end
    #         end
    #         puts "#{@dashes} "
    #         if !@dashes.include?("-")
    #             puts "You Won Hangman!"
    #             puts "/ᐠ｡ꞈ｡ᐟ\\"
    #             puts "#{@dashes}"
    #             break
                
    #         end
    #     end
    # end
#If the player makes a wrong guess
    def wrong_guess(letter)
        @wrong_guesses << letter
        puts "Wrong Guess!"
        puts "#{@wrong_guesses}"
        puts Hangman.shape[@count]          #Call for Hangman model
        @count += 1
        if @count >= 7
            puts "Better luck next time, " + Player.last.name
            play_again
        end
    end

#Check if the player wants to continue the game
    def play_again
        puts "Please type 'yes' to play again or anything else to exit the game"
        word = gets.chomp.to_s.downcase
        if word == 'yes'
            hang1 = HangmanGame.new
            hang1.start
        else 
            puts "Bye, thank you for playing! Have a great day :)"
            exit
        end
    end

#Total number of players
    def game_players
        Player.count
    end 

#Update word -> score
    def update_word
        word = Word.find_by(word: @random.join(""))
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

end


hang = HangmanGame.new
hang.start
# game = hang.guessing_letters
# hang.play_again

#Players count
total = hang.game_players
#puts "Hangman players - #{total}"
