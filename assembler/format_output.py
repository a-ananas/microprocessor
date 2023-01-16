file_name = "tests/double_dabble.i"

file = open(file_name, 'r')
lines = file.readlines()

print("+" + 36*"-" + "+")
for i,line in enumerate(lines):
    string = str("|" + line[:5] + "|" + line[5:10] + "|" + line[10:15] + "|" + line[15:20] + "|" + line[20:-1] + "| " + str(i))
    print(string)
print("+" + 36*"-" + "+")
    
