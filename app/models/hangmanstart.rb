require 'pry'
require_relative './Hangman.rb'

class Hangman


    attr_accessor :username
    attr_reader :secret_word, :alpha, :random_word

    def initialize
        @alpha = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
        @secret_word = ["horse", "birth", "mouse", "apple", "black", "white", "water", "users", "comes", "yummy", "hyper", "cards", "blink", "stick", "every", "using", "trust", "pluck", "trees", "proud"]
        @dashes = ["-","-","-","-","-"]
        @attempts = 0
        # @random_word = @secret_word.sample.split("")
        @random_word = ['b','i','r','t','h']
        #@correct_letters = []
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
            puts @dashes.join(" ")
            puts "==============================="

            puts "Start by guessing the word with one letter at a time and click enter"
            guessing_letters

    end

    def guessing_letters
         #gets always returns a string
        # index = 0
        while @attempts < 10 do
            @attempts += 1
            #binding.pry
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
                        #binding.pry
                        @guessed_letters << letter
                        #@wrong_guesses << letter
                        
                        if @random_word.include?(letter)
                            @random_word.each.with_index do |char, index|
                                if char == letter
                                    #binding.pry
                                    @dashes[index] = char
                                    # puts @dashes
                                    #put well done message
                                end
                                if !@dashes.include?("-")
                                    return "You Won Hangman!"
                                end
                            end
                            # binding.pry
                            #this is where i update the board based on proper guess
                            
                        
                        
                        else
                            wrong_guess(letter) #counter dependent on hangman
                            
                        end

                    end
                        
                        
                end
            end
            puts "#{@dashes} "
            # index += 1
        end

    end

    def wrong_guess(letter)
        @wrong_guesses << letter
        puts "Wrong Guess!"
        puts "#{@wrong_guesses}"
        Hangman.shape[@count]
        @count += 1
        #display @hangmanarray so they can see wrong guess

    end
    # def guessing_letters
    #     letter = gets.chomp.to_s.downcase
        # if @alpha.include?(letter)
        #     #guessing_letters
        # elsif puts "#{letter.upcase} is not valid!"
        #     guessing_letters

        #     if letter.length = 1
        #         guessing_letters
        #     elsif puts "please only enter one letter in the alphabet"
        #         guessing_letters

        #         if @guessed_letters.include?(letter)
        #             puts "#{letter.upcase} has already been guessed!"
        #         else
        #             @guessed_letters << letter

        #             if  @random_word.include?(letter)
        #                 puts "#{letter.capitalize} was found! Well done! You are getting Closer!"
        #                 @correct_letters << letter
          
        #             else 
        #                  puts "#{letter.capitalize} was not found! Keep trying!"
                            
        #                 @wrong_guesses << letter
        #                 @count += 1
        #                 Hangman.shape[@count]
        #                 binding.pry
            
    #           end
    #         end
    #        end
    #        guessing_letters
    #     end
    # end

end


hang = Hangman.new
hang.start
game = hang.guessing_letters
puts "done"
