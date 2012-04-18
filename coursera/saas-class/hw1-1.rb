def palindrome?(string)
    sub=string.downcase.gsub(/[^a-z]/,'')
    sub.reverse==sub
end

#puts palindrome? "Madam, I'm Adam!"

def count_words(string)
    word_hash={}
    word_list=string.downcase.scan(/\w+/i)
    word_list.each do |s|
        if word_hash[s].nil?
            word_hash[s]=1
        else
            word_hash[s]+=1
        end
    end
    word_hash
end

#puts count_words("A man, a plan, a canal -- Panama")

