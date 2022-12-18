import re

regex = "^((25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])\.){3}(25[0-5]|2[0-4][0-9]|1[0-9][0-9]|[1-9]?[0-9])$"

def check(Ip):
 
    # pass the regular expression
    # and the string in search() method
    if(re.search(regex, Ip)):
        print("Valid Ip address")
         
    else:
        print("Invalid Ip address")

def defang(ip: str) -> str:
    ans = ''
    for char in ip:
        if char == ".":
            ans += "[.]"
        else:
            ans += char
    return ans 
    #return ip.replace(".", "[.]")
validInput = False

while not validInput:
    testIP = input("Enter the desired IP address:")

print("Defanged:", defang(testIP))