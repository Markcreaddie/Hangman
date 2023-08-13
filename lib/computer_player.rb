class ComputerPlayer
    attr_accessor :name,:random_word, :guess_limit, :remaining_chars, :valid_chars, :selected_chars

    def initialize()
        self.name= "computer"
        self.remaining_chars=*('a'..'z')
        self.selected_chars = []
    end
    
    def pick_random_word(dict_words)  
        random_word=dict_words[rand(dict_words.count)]
        if random_word.length>=5 && random_word.length<=12
            self.valid_chars=random_word.chars.uniq
            return random_word
        end
        pick_random_word(dict_words)
    end

    def set_guess_limit()
        self.guess_limit=rand(7..9)
        puts <<~TEXT
        You have a total of #{guess_limit} guesses to make
        TEXT
    end

    def reduce_guesses()
        self.guess_limit-=1
        puts <<~TEXT
        You have #{guess_limit} #{guess_limit==1 ? 'guess': "guesses"} left

        TEXT
    end


    def correct_word(guess)
        guess==random_word
    end


    def validate_guess(char,board)
        unless self.remaining_chars.include?(char)
            puts <<~TEXT
            #{char} has already been guessed. Pick another character.
            TEXT
            return
        end
        if valid_chars.include?(char)
            char_indices=[]
            random_word.chars.each_with_index do |letter,index|
                if letter==char
                    char_indices.push(index)
                end
            end
            board.display_correct_chars(char_indices,char)
        else
            board.display_wrong_chars(char)
            reduce_guesses()
        end
        self.remaining_chars.delete(char)
        self.selected_chars.push(char)
    end

end