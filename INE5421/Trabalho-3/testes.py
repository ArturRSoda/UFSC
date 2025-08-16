from main import main

input1 = "{S,A,B}{a,b,c}{S}{S = AB; S = Sc; A = aA; A = &; B = bB; B = &}"
input2 = "{S,A,B,C,D}{a,b,d,c,d}{S}{S = AB; S = aS; A = bA; A = BC; B = dB; B = C; B = &; C = cCc; C = BD; D = CD; D = d; D = &}"
input3 = "{S,B,A}{d,b,c,a}{S}{S = Bd; S = &; B = Ab; B = Bc; A = Sa; A = &}"

input4 = "{S,A,B,C}{a,c,b}{S}{S = ABB; S = CAC; A = a; B = Bc; B = ABB; C = bB; C = a}"
input5 = "{S,A,B}{a,b,c}{S}{S = aS; S = SB; S = SS; S = b; A = ASB; A = c; B = b}"
input6 = "{S,A}{a,b,c,d}{S}{S = Aa; S = b; A = Ac; A = Sd; A = a}"

input7 = "{A,B,S}{a,b,c,d}{S}{S = Bd; S = &; B = Bc; B = b; B = Ab; A = Sa; A = a}"

print("INPUT 1")
main(input1)

print()
print()

print("INPUT 2")
main(input2)

print()
print()

print("INPUT 3")
main(input3)

print()
print()

print("INPUT 6")
main(input6)

print()
print()

print("INPUT 7")
main(input7)
