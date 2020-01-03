require 'pry'
require_relative './string'

class HangmanGame 

    attr_accessor :username, :player
    attr_reader :alpha, :random_word

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        @dashes = ["-","-","-","-","-"]
        @attempts = 0
        @wrong_guesses = []
        @guessed_letters = []
        @count = 0
        @guessed_count = 0
    end

    def random_word
        word_list = old_player
        random = Word.all.sample.word
        @random_word = random.split("")
        if word_list.length > 0
            while word_list.include?(@random_word.join("")) do
                @random_word = Word.all.sample.word.split("")
            end
        end
    end

    def greetings
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "/ᐠ｡ꞈ｡ᐟ\\ Welcome to Hangman! /ᐠ｡ꞈ｡ᐟ\\ " .blue
        puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts "Where you have to guess the Secret word by putting in letters before the man gets hung!".blue

        puts "********************************"
        puts 'Enter a username:'.blue
        @username = gets.chomp
        start
    end

    def start
        enter_username  #check for the valid player
        random_word     #choose a random word from table
        puts "********************************"
        puts "            "
        puts "Here's the word:".blue
        puts "☟ ☟ ☟ ☟ ☟"
        puts "    "
        puts @dashes.join(" ")
        puts "==============================="
        puts "Start by guessing the word with one letter at a time and click enter, remember you have only 10 attempts to guess the word"
        guessing_letters
    end

#Check for player's name
    def enter_username
        while @username.length == 0 do
            puts "!!!!!!!!!!!!You need to enter a Username!!!!!!!!!!!!".red
            puts "   "
            puts 'Enter a username:'.blue
                @username = gets.chomp
        end
        name = Player.find_by(name: @username)
        if !Player.exists?(name: @username) 
            @player = Player.create(name: @username)
        else
            @player = Player.find_by(name: @username)
        end
        
    end

#Check if the input given by player is a letter (check for alphabet and its length)
    def validation?(letter)
        if !@alpha.include?(letter)
            puts "#{letter} is not valid!".red
            @attempts -= 1
            return true
        elsif letter.length > 1  && letter != 'exit'
            puts "please only enter one letter in the alphabet".red
            @attempts -= 1
            return true
        end
        return false
    end

#Check if its already guessed by player
    def is_guessed?(letter)
        if @guessed_letters.include?(letter)
            puts "#{letter.upcase} has already been guessed!".red
            @attempts -= 1
            @guessed_count += 1
            if @guessed_count > 10
                puts "You guesses the same word many times."
                # puts "Better luck next time, ".brown + Player.last.name + ". Its " +"#{@random_word.join("")}".bold.underline
                # puts " Your total score is #{Player.last.score}"
                puts "Better luck next time, ".brown + @player.name + ". Its " +"#{@random_word.join("")}".bold.underline
                puts " Your total score is #{@player.score}"
                exit
            end
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
        Player.last.words << Word.find_by(word: @random_word.join(""))
        while @attempts < 10 do  
            
            letter = gets.chomp.downcase
            if letter == 'exit'
                    abort
            end
            if !validation?(letter) && !is_guessed?(letter)
                right_guess(letter)
            end
            puts "#{@dashes}                                            #{9 - @attempts} attempts remaining"
            if check_for_dashes?
                play_again
            else
                if @attempts < 9
                    @attempts += 1
                elsif @guessed_count > 10
                    puts "You guesses the same word many times.".red
                    # puts "Better luck next time, ".brown + Player.last.name + ". Its " + "#{@random_word.join("")}".bold.underline
                    # puts " Your total score is #{Player.last.score}".brown
                    puts "Better luck next time, ".brown + @player.name + ". Its " + "#{@random_word.join("")}".bold.underline
                    puts " Your total score is #{@player.score}".brown
                else
                    # puts "Better luck next time, ".brown + Player.last.name + ". Its " + "#{@random_word.join("")}".bold.underline
                    # puts " Your total score is #{Player.last.score}".brown
                    puts "Better luck next time, ".brown + @player.name + ". Its " + "#{@random_word.join("")}".bold.underline
                    puts " Your total score is #{@player.score}".brown
                    play_again
                end
            end
        end
    end

#Check if the player guessed the secret word?
    def check_for_dashes?
        if !@dashes.include?("-")
            puts "#{@dashes.join("")}".upcase.bold.underline
            update_player
            # puts "Good job ".green.bold + Player.last.name + ", You Won Hangman!".green.bold.blink
            # puts " Your total score is #{Player.last.score}".brown
            puts "Good job ".green.bold + @player.name + ", You Won Hangman!".green.bold.blink
            puts " Your total score is #{@player.score}".brown
            puts "/ᐠ｡ꞈ｡ᐟ\\"
            return true
        end
        return false
    end

    
#If the player makes a wrong guess
    def wrong_guess(letter)
        @wrong_guesses << letter
        puts "Wrong Guess! = > #{@wrong_guesses}".magenta
        puts Hangman.shape[@count].red               #Call for Hangman model
        @count += 1
        if @count >= 7
            # puts "Better luck next time, ".magenta  + Player.last.name + ". Its " + "#{@random_word.join("")}".bold.underline
            # puts " Your total score is #{Player.last.score}".brown
            puts "Better luck next time, ".magenta  + @player.name + ". Its " + "#{@random_word.join("")}".bold.underline
            # binding.pry
            name = Player.find_by(name: @username).score
            puts " Your total score is #{name}".brown
            play_again
        end
    end

#Check if the player wants to continue the game
    def play_again
        puts "Please type 'yes' to play again or enter another key to exit the game".blue
        word = gets.chomp.to_s.downcase
        if word == 'yes'
            initialize
            start
            
        else 
            puts "Bye, thank you for playing! Have a great day :)".cyan
            exit
        end
    end

#Total number of players
    def game_players
        Player.count
    end 

#Update Player -> score
    def update_player
        @player.score += 10
        @player.save
    end


#Check if the player's name already exists in database
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

#Find the player with highest score
    def top_player
        score = Player.maximum('score')
        name = Player.find_by(score: score).name
        puts "#{name.upcase} you have the highest score among #{Player.all.count} players.".magenta
    end

#Show all the words the player has played with
    def show_words_list(given_name)
        if !Player.exists?(name: given_name) 
            puts "#{given_name.capitalize} haven't played this game yet, make #{name.capitalize} play hangman."
        else
            name = Player.find_by(name: given_name)
            puts "#{given_name.capitalize} tried the below words:"
            name.words.each do |ele|
                puts ele.word
            end
        end
    end
end