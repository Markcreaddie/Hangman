
def read_file(file_name)
    file = File.open(file_name, "r")
    data = file.read
    file.close
    return data.split("\n")
end

dict_words=read_file("google-10000-english-no-swears.txt")

def pick_random_word(my_array)  
    selected_word=my_array[rand(my_array.count)]
    if selected_word.length>=5 && selected_word.length<=12
        return selected_word
    end
    pick_random_word(my_array)
end

p pick_random_word(dict_words) 
