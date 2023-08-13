class Board
    attr_accessor :correct_chars, :wrong_chars
    
    def initialize(guess)
        self.correct_chars=""
        create_empty_board(guess)
    end

    def create_empty_board(guess)
        word_length=guess.length
        word_length.times do|i| 
            unless i+1==word_length
                self.correct_chars +="_ "
            else
                self.correct_chars +="_"
            end
        end
        puts <<~TEXT
        The chosen word is #{word_length} characters long.
        #{correct_chars}
        TEXT
    end

    def display_correct_chars(char_indices,char)
        char_indices.each{|index| self.correct_chars[index*2]=char}
        puts <<~TEXT
        #{char} exists in the word.
        #{correct_chars}

        TEXT
    end

    def display_wrong_chars(char)
        puts <<~TEXT
        #{char} does not exist in the word.
        #{correct_chars}
        
        TEXT
    end
end