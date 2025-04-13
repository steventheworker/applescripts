set txt to text returned of (display dialog "port:" default answer "") # port
if txt is equal to "" then return
return do shell script ("kill -9 $(lsof -t -i:" & txt & ")")