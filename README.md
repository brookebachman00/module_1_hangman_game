**Hangman**
Hangman is a command line game. To run the game type *** bundle exec ruby bin/run.rb *** into the command line after navigating to the current directory. This game was written in Ruby and utilizes YAML for saving / loading games. You will also need to create your database so make sure you run db:migrate, then db:seed.

**Game Interface**
In Hangman when you start playing you will be given a visual on correct letters and wrong letters as well as a hangman graphic itself to let you know how close you are.

**How to Play:**
When a new game is started, you will have 10 chances to guess the secret 5 letter word before the man is hung! Guess one letter at a time and click enter/return. You win by guessing correctly what the secret word is. You lose by guessing too many times.You are playing against me! Goodluck!
