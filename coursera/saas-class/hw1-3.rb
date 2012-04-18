def combine_anagrams(words)
    result=[]
    i=0
    words.each do |word|
        if word!=nil then
            anagram=[word]
            words[i]=nil
            j=0
            words.each do |word_left|
                if word_left!=nil and word.downcase.split(//).sort==word_left.downcase.split(//).sort
                    anagram+=[word_left]
                    words[j]=nil
                end
                j=j+1
            end
            result+=[anagram]
        end
        i=i+1
    end
    result
end
#input=["test","tste","SETT","ETst","good"]
#input=["test","tste","SETT","ETst"]
#input=["a","b","c"]
input=['cars', 'for', 'potatoes', 'racs', 'four','scar', 'creams','scream', 'scream']

#input=['rat', 'tar', 'panes', 'napes', 'snape','scar', 'dart','tard']
#input=['a', 'a', 'b', 'b', 'c','d']
result = combine_anagrams(input)
puts result.inspect
