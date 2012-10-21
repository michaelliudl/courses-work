balance = 4213.
annualInterestRate = .2
monthlyPaymentRate = .04

#payment = balance * monthlyPaymentRate
#balance = (balance - payment) * (1 + annualInterestRate / 12)
#payed = payment
payed = 0.
for m in range(12):
    payment = balance * monthlyPaymentRate
    payed += payment
    balance = (balance - payment) * (1 + annualInterestRate / 12)
    print "Month: %d" % (m + 1)
    print "Minimum monthly payment: " + str(round(payment, 2))
    print "Remaining balance: " + str(round(balance, 2))

print "Total paid: " + str(round(payed, 2))
print "Remaining balance: " + str(round(balance, 2))

