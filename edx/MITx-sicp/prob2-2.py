balance = float(raw_input("input initial balance:"))
annualInterestRate = float(raw_input("input annual interest rate:"))

def calc_monthly(months):
    return int(balance / months) / 10 * 10
monthly_min = calc_monthly(12)
monthly_max = calc_monthly(6)

#for monthly in range(monthly_min, monthly_max, 10):
for monthly in range(10, 1000, 10):
    b = balance
    for m in range(12):
        b = (b - monthly) * (1 + annualInterestRate / 12)
    if b < 0:
        print "Lowest Payment: %d" % int(monthly)
        break
