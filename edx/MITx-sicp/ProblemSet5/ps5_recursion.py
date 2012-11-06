# 6.00x Problem Set 5
#
# Part 2 - RECURSION

#
# Problem 3: Recursive String Reversal
#
def reverseString(aStr):
    """
    Given a string, recursively returns a reversed copy of the string.
    For example, if the string is 'abc', the function returns 'cba'.
    The only string operations you are allowed to use are indexing,
    slicing, and concatenation.
    
    aStr: a string
    returns: a reversed string
    """
    ### TODO.
    if len(aStr) == 0 or len(aStr) == 1:
        return aStr
    else:
        return aStr[-1] + reverseString(aStr[1:-1]) + aStr[0]

'''print reverseString("")
print reverseString("a")
print reverseString(" ")
print reverseString("ab")
print reverseString("abc")
print reverseString("acdb")
print reverseString("bdacx")
'''

#
# Problem 4: Erician
#
def x_ian(x, word):
    """
    Given a string x, returns True if all the letters in x are
    contained in word in the same order as they appear in x.

    >>> x_ian('eric', 'meritocracy')
    True
    >>> x_ian('eric', 'cerium')
    False
    >>> x_ian('john', 'mahjong')
    False
    
    x: a string
    word: a string
    returns: True if word is x_ian, False otherwise
    """
    ###TODO.
    if len(x) == 0:
        return True
    elif len(word) == 0:
        return False
    else:
        first = x[0]
        first_pos = word.find(first)
        if first_pos < 0:
            return False
        else:
            return x_ian(x[1:], word[first_pos + 1:])

'''print x_ian('eric', 'meritocracy')
print x_ian('eric', 'cerium')
print x_ian('john', 'mahjong')'''
#
# Problem 5: Typewriter
#
def insertNewlines(text, lineLength):
    """
    Given text and a desired line length, wrap the text as a typewriter would.
    Insert a newline character ("\n") after each word that reaches or exceeds
    the desired line length.

    text: a string containing the text to wrap.
    line_length: the number of characters to include on a line before wrapping
        the next word.
    returns: a string, with newline characters inserted appropriately. 
    """
    ### TODO.
    if len(text) <= lineLength:
        return text + '\n'
    else:
        space_pos = text.find(' ', lineLength - 1)
        if space_pos < 0:
            return text + '\n'
        else:
            return text[:space_pos] + '\n' + insertNewlines(text[space_pos+1:], lineLength)

print insertNewlines('While I expect new intellectual adventures ahead, nothing will compare to the exhilaration of the world-changing accomplishments that we produced together.', 15)
print insertNewlines('Nuh-uh! We let users vote on comments and display them by number of votes. Everyone knows that makes it impossible for a few persistent voices to dominate the discussion.', 20)
