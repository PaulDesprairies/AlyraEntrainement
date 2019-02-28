
from datetime import timedelta 
from datetime import date

d0 = date(1970, 1, 1)
d1 = date(2019, 1, 1)
delta = d1 - d0
n = 16**8-1
while ((delta.days * 24 * 3600)-n)/(24*3600) < 0 :
    d1 = d1 + timedelta(days=1)
print(d1)


#d1 = date(2106, 2, 7)
