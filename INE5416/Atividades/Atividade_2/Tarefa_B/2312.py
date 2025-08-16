class Country:
    def __init__(self, name, gold, silver, bronze):
        self.name = name
        self.gold = gold
        self.silver = silver
        self.bronze = bronze

n = int(input())

countries = list()
for _ in range(n):
    inp = list(input().split())
    countries.append(Country(inp[0], int(inp[1]), int(inp[2]), int(inp[3])))

for i in range(n-1):
    for j in range(n-i-1):
        c1 = countries[j]
        c2 = countries[j+1]
        if (c2.gold > c1.gold):
            countries[j], countries[j+1] = countries[j+1], countries[j]

        elif (c2.gold == c1.gold):
            if (c2.silver > c1.silver):
                countries[j], countries[j+1] = countries[j+1], countries[j]

            elif (c2.silver == c1.silver):
                if (c2.bronze > c1.bronze):
                    countries[j], countries[j+1] = countries[j+1], countries[j]

                elif (c2.bronze == c2.bronze):
                    if (c2.name < c1.name):
                        countries[j], countries[j+1] = countries[j+1], countries[j]

for v in countries:
    print(v.name, v.gold, v.silver, v.bronze)

