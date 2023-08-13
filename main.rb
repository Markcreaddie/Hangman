require "./lib/board.rb"
require "./lib/hangman.rb"

def start_game()
    puts <<~TEXT
    Would you like to:
    [1] Start a new game
    [2] Resume a previous game

    TEXT
    option= gets.chomp!()
    if option == "1" || option == "2"
        return option
    end
    puts "\n#{option} is not a valid choice.\nPick 1 or 2\n\n"
    start_game()
end


game =Hangman.new(start_game())
game.play()

p game.serialize
#Board1=Board.new("rampage")
