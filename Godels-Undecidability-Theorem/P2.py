
# Tyler Edwards
# 4 - 24 - 2020

# Program that implements the following function
# f is N -> N
# f(n) = n/2, when n is even
#      = 3n + 1, when n is odd
# for every n, there is an integer i that fi(n) = 1

#   2.]
print()
def P2():
    try:
        n = int(input("Please enter a natural number | "))
        if (n <= 0):
            print("ERROR | Please enter a natural number (int > 0)")
            P2()
        i = 1
        while (n != 1):
            if (n % 2 == 0):
                n = n / 2
                print("||| ", int(n))
            else:
                n = (3*n) + 1
                print("||| ", int(n))
            i = i + 1
        print()
        print("||| i = ", i)
        print()
    except ValueError:
        print("ERROR | Please enter an integer.")
        print()
        P2()


P2()
print("Hello")
