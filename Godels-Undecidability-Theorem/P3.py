
# Tyler Edwards
# 4 - 24 - 2020

# Takes a list of prime numbers and returns them as a Godel statement

#   3.]
print()
def P3():
    print("Please enter a list of Godel numbers between 1 and 23. (Enter -1 when finished)")
    print()
    godel = [1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23]
    primelist = [2, 3, 5, 7, 11, 13, 15, 17, 23, 29, 31]
    s = []
    g = 1
    try:
        while g >= 0:
            print("Your list ", s)
            g = int(input())
            if (g in godel):
                s.append(g)
            elif (g != -1):
                print()
                print("ERROR | NOT A GODEL #")
                print("Please enter a list of Godel numbers between 1 and 23. (Enter -1 when finished)")
        print()
        print("Your list is ", s)
        print()
        print("Your full godel number is ")
        full = []
        # print("S Length", len(s))
        k = 0
        while k < len(s):
            # print(k)
            print(str(primelist[k]), end = "")
            print("^", end = "")
            print(str(s[k]), " ", end = "")
            k = k + 1
        print()
        print()

        symbols = []
        for i in s:
            if (i == 1):
                symbols.append("0")
            elif (i == 3):
                symbols.append("f")
            elif (i == 5):
                symbols.append("¬")
            elif (i == 7):
                symbols.append("v")
            elif (i == 9):
                symbols.append("A")
            elif (i == 11):
                symbols.append(")")
            elif (i == 13):
                symbols.append(")")
            elif (i == 15):
                symbols.append("^")
            elif (i == 17):
                symbols.append("E")
            elif (i == 19):
                symbols.append("=")
            elif (i == 21):
                symbols.append("x")
            elif (i == 23):
                symbols.append("y")
        print(*symbols)
    except ValueError:
        print("ERROR | Please enter a list of godel numbers.")
        print()
        P3()


P3()
