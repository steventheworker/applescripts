set n to text returned of (display dialog "Enter the value of n:" default answer "")

set pythonScript to quoted form of POSIX path of "/Users/super/proj/py/perm/main.py"
set response to do shell script "python3 " & pythonScript & " " & n
display dialog response
