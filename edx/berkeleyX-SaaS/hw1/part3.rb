def combine_anagrams(words)
    result = {}
    words.each do |w|
        key = w.downcase.each_char.sort.to_s
        if result[key]
            result[key] << w
        else
            result[key] = [w]
        end
    end
    result.values
 # YOUR CODE HERE
end
words = ['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams', 'scream']
p combine_anagrams(words)
