
# Tyler Edwards
# 4 - 24 - 2020

# # Takes two positive integers > 2 and writes them as the sum of 2 primes.

#   1.]
print()

def isPrime(i):
    if i < 2:
        return False
    for j in range(2,i):
        if i % j == 0:
            return False
    return True

def P1():
    try:
        x = int(input("Please enter an even positive integer greater than 2 | "))
        if (x % 2 != 0 | x == 2):
            print("ERROR | Please enter an even positive integer greater than 2.")
            P1()
        else:
            print("Please wait...")
            primes = []
            for i in range(2, x//2):
                #print("i = " , i)
                if (isPrime(i)):
                    primes.append(i)
            if (isPrime(int(x/2))):
                primes.append(int(x/2))

            # Test list for Goldbach
            for p in primes:
                dif = x - p
                if(isPrime(dif)):
                    print()
                    print(p, " + ", dif, " = ", x)
                    print()
                    exit()
            print("Goldbach's Conjecture is false.")

    except ValueError:
        print("ERROR | Please enter an integer.")
        print()
        P1()
# -----------------------------------------------------------------------------------------------------------------

P1()
