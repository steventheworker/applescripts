set txt to text returned of (display dialog "paste medium link:" default answer "")
if (txt is equal to "") then return
set link to "https://freedium.cfd/" & txt
open location link