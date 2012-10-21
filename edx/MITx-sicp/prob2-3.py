balance = float(raw_input("input initial balance:"))
annualInterestRate = float(raw_input("input annual interest rate:"))

monthly_min = balance / 12
monthly_max = balance * ((1 + annualInterestRate / 12) ** 12) / 12
while (True):
    monthly = (monthly_min + monthly_max) / 2
    b = balance
    for m in range(12):
        b = (b - monthly) * (1 + annualInterestRate / 12)
    if b <= 0 and b > -0.1:
        print "Lowest Payment: " + str(round(monthly, 2))
        break
    elif b > 0:
        monthly_min = monthly
    else:
        monthly_max = monthly
