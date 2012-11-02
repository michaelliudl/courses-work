# 6.00x Problem Set 3
#
# Successive Approximation: Newton's Method
#


# Problem 1: Polynomials
def evaluatePoly(poly, x):
    '''
    Computes the value of a polynomial function at given value x. Returns that
    value as a float.
 
    poly: list of numbers, length > 0
    x: number
    returns: float
    '''
    # FILL IN YOUR CODE HERE...
    result = 0
    for i in range(len(poly)):
        result += poly[i] * (x ** i)
    return result

print evaluatePoly([0.0, 0.0, 5.0, 9.3, 7.0], -13)






# Problem 2: Derivatives
def computeDeriv(poly):
    '''
    Computes and returns the derivative of a polynomial function as a list of
    floats. If the derivative is 0, returns [0.0].
 
    poly: list of numbers, length &gt; 0
    returns: list of numbers (floats)
    '''
    # FILL IN YOUR CODE HERE...
    result = []
    for i in range(len(poly)):
        if i == 0 and poly[i] != 0.0:
            result.append(0.0)
        if i > 0:
            result.append(float(poly[i] * i))
    return result

print computeDeriv([-13.39, 0.0, 17.5, 3.0, 1.0])
print computeDeriv([0, 4, 0, 2, 4])
print computeDeriv([0, 5.91])



# Problem 3: Newton's Method
def computeRoot(poly, x_0, epsilon):
    '''
    Uses Newton's method to find and return a root of a polynomial function.
    Returns a list containing the root and the number of iterations required
    to get to the root.
 
    poly: list of numbers, length > 1.
         Represents a polynomial function containing at least one real root.
         The derivative of this polynomial function at x_0 is not 0.
    x_0: float
    epsilon: float > 0
    returns: list [float, int]
    '''
    # FILL IN YOUR CODE HERE...
    x = x_0
    result = [x, 0]
    value = evaluatePoly(poly, x)
    while abs(value) >= epsilon:
        x = x - value / evaluatePoly(computeDeriv(poly), x)
        value = evaluatePoly(poly, x)
        result[0] = x
        result[1] = result[1] + 1
    return result

print computeRoot([-13.39, 0.0, 17.5, 3.0, 1.0], 0.1, 0.0001)
