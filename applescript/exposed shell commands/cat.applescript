set txt to text returned of (display dialog "path:" default answer "") # path
display dialog (do shell script ("cat " & (quoted form of txt)))
