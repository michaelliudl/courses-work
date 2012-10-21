#For those just starting out, one suggested way to work on your code is to have a command window open and a text editor with this
#file loaded.  Make changes to this file and then run 'ruby part1.rb' at the command line, this will run your program.  Once you're
#satisfied with your work, save your file and upload it to the checker.


def palindrome?(str)
    s = str.gsub(/[^a-zA-Z]*/, '').to_s.downcase
    s.reverse == s
  # YOUR CODE HERE
end

def count_words(str)
    result = {}
    str.split(/\b[^a-zA-Z]*\b/).each do |word|
        result[word.downcase] = 0 unless result[word.downcase]
        result[word.downcase] += 1
    end
    result
  # YOUR CODE HERE
end


#the code below this line will test your functions.  You should remove everything below this line prior to submitting your file


test_str = "there goes the neighborhood"

if palindrome? test_str
  puts test_str + " is a palindrome!"
else
  puts test_str + " is NOT a palindrome!"
end


test_str = "Madam, I'm Adam"

if palindrome? test_str
  puts test_str + " is a palindrome!"
else
  puts test_str + " is NOT a palindrome!"
end


test_str = "The rent is due on the first day of the month unless the first day of the month falls on a Saturday or Sunday"

word_count = count_words test_str
puts word_count
