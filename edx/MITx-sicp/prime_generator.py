def genPrimes():
    def isPrime(n):
        for i in xrange(2, n-1):
            if n % i == 0:
                return False
        return True
    current = 2
    while True:
        if isPrime(current):
            yield current
        current += 1
p = genPrimes()
for prime in p:
    print prime
