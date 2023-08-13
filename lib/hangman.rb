require "./lib/computer_player.rb"
require "./lib/board.rb"
require "./lib/serialization.rb"

class Hangman
    include BasicSerializable

    attr_accessor :player1, :board, :name

    def initialize(option)
        self.player1=ComputerPlayer.new()
        self.board= Board.new(player1.random_word)
        self.name="my_game"
        if option== "1"
            new_game()
        else
            resume_game()
        end
    end

    def new_game()
        puts "\nA new game has started"
        dict_words=get_dict_words()
        player1.random_word=player1.pick_random_word(dict_words)
        player1.set_guess_limit()
    end

    def resume_game()
        puts "\npick the game to resume"
    end


    def get_dict_words()
        file = File.open("./lib/dictionary.txt", "r")
        data = file.read
        file.close
        return data.split("\n")
    end

    def declare_outcome(random_word,correct_chars)
        guessed_word=correct_chars.delete(" ")
        if guessed_word==random_word
            puts <<~TEXT
            Congratulations!!
            You guessed the word '#{random_word}' correctly
            TEXT
        else
            puts <<~TEXT
            You lose!!
            The correct word is #{random_word}
            TEXT
        end
    end



    def play()
        while player1.guess_limit>0 && board.correct_chars.include?("_")
            puts "\nSelected letters: #{player1.selected_chars.join(" ")}\nMake a guess:"
            char= gets.chomp!.downcase
            if player1.correct_word(char)
                break
            elsif char.length>1
                puts "Select only one character between 'a'-'z'"
                next
            end
            player1.validate_guess(char,board)
        end
        declare_outcome(player1.random_word,board.correct_chars)
    end
end