def myLog(x, b):
    assert x > 0
    assert b > 0
    power = 1
    for i in range(x / b + 1):
        power = b ** i
        if power == x:
            return i
        elif power > x:
            return i - 1
    return 0

#print myLog(0, 0)
'''print myLog(16, 2)
print myLog(15, 3)
print myLog(27, 3)
print myLog(2, 16)
print myLog(10, 3)
print myLog(10, 4)'''

def laceStringsIter(s1, s2):
    if len(s1) == 0:
        return s2
    elif len(s2) == 0:
        return s1
    shorter = min(len(s1), len(s2))
    result = ''
    i = 0
    while i < shorter:
        result += s1[i]
        result += s2[i]
        i += 1
    if len(s1) > shorter:
        result += s1[shorter:]
    elif len(s2) > shorter:
        result += s2[shorter:]
    return result

def laceStringsRecur(s1, s2):
    def helpLaceStrings(s1, s2, out):
        if s1 == '':
            return out + s2
        if s2 == '':
            return out + s1
        else:
            return helpLaceStrings(s1[1:], s2[1:], out + s1[0] + s2[0])

    return helpLaceStrings(s1, s2, '')

def laceStrings(s1, s2):
    return laceStringsRecur(s1, s2)

'''print laceStrings('', '')
print laceStrings('', 'a')
print laceStrings('b', '')
print laceStrings('abcd', 'efgh')
print laceStrings('abc', 'efghi')
print laceStrings('zyxw', 'a')
print laceStrings('ghi', 'opq')
print laceStrings('abcd', 'efghi')'''

def fixedPoint(f, epsilon):
    guess = 1.0
    for i in range(100):
        if abs(f(guess) - guess) < epsilon:
            return guess
        else:
            guess = f(guess)
    return guess

def sqrt(a):
    def tryit(x):
        return 0.5 * (a/x + x)
    return fixedPoint(tryit, 0.0001)

def babylon(a):
    def test(x):
        return 0.5 * ((a/x) + x)
    return test

def sqrt1(a):
    return fixedPoint(babylon(a), 0.0001)

#print sqrt1(2.0)
def McNuggets(n):
    def nug(remaining, nuggets):
        if remaining < 0:
            return False
        if remaining == 0:
            return True
        if len(nuggets) == 0:
            return False
        else:
            return nug(remaining - nuggets[0], nuggets) or \
                    nug(remaining, nuggets[1:])
    return nug(n, [6, 9, 20])
print McNuggets(-1)
print McNuggets(0)
print McNuggets(1)
print McNuggets(6)
print McNuggets(8)
print McNuggets(9)
print McNuggets(10)
print McNuggets(12)
print McNuggets(13)
print McNuggets(15)
print McNuggets(16)
print McNuggets(18)
print McNuggets(19)
print McNuggets(20)
print McNuggets(22)
print McNuggets(24)
print McNuggets(26)
print McNuggets(27)
print McNuggets(30)
print McNuggets(32)
print McNuggets(35)
print McNuggets(37)
print McNuggets(38)
print McNuggets(40)
print McNuggets(45)
