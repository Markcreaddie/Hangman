require "./lib/computer_player.rb"
require "./lib/board.rb"
require "./lib/serialization.rb"

class Hangman
    include BasicSerializable

    attr_accessor :player1, :board, :name

    def initialize(option)
        self.name="my_game"
        if option== "1"
            new_game()
        else
            self.player1=ComputerPlayer.new()
            self.board= Board.new(player1.random_word)
            resume_game()
        end
    end

    def new_game()
        self.player1=ComputerPlayer.new()
        puts "\nA new game has started"
        dict_words=get_dict_words()
        player1.random_word=player1.pick_random_word(dict_words)
        self.board= Board.new(player1.random_word)
        player1.set_guess_limit()
    end

    def resume_game()
        puts <<~TEXT
        pick the game to resume

        #{Dir.entries("./lib/my_games/")}
        TEXT
        game_path="./lib/my_games/#{gets.chomp!.downcase}"
        my_game=File.open(game_path,"r").read
        unserialize(my_game)
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

    def save_game()
        serialized_game=serialize()
        puts "Enter a name for this game:"
        game_name=gets.chomp!.downcase
        my_game=File.open("./lib/my_games/#{game_name}.txt","w")
        my_game.write(serialized_game)
        my_game.close
    end

    def play()
        while player1.guess_limit>0 && board.correct_chars.include?("_")
            puts <<~TEXT
            Selected letters: #{player1.selected_chars.join(" ")}
            Make a guess:
            TEXT
            char= gets.chomp!.downcase
            if player1.correct_word(char)
                break
            elsif char.length>1
                puts "Select only one character between 'a'-'z'"
                next
            end
            player1.validate_guess(char,board)
            puts <<~TEXT
            Do you want to exit the game?

            [1] Yes
            [2] No
            TEXT
            response=gets.chomp!.downcase
            if response == "1"
                save_game()
                return
            end
        end
        declare_outcome(player1.random_word,board.correct_chars)
    end
end