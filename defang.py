def defang(ip: str) -> str:
    ans = ''
    for char in ip:
        if char == ".":
            ans += "[.]"
        else:
            ans += char
    return ans 
    #return ip.replace(".", "[.]")
    
testIP = input("Enter the desired IP address:")

print("Defanged:", defang(testIP))
