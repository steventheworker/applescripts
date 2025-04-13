set userInput to text returned of (display dialog "Enter a number to calculate its factorial:" default answer "")

-- Function to calculate factorial
on factorial(n)
	if n ² 1 then
		return 1
	else
		return n * (factorial(n - 1))
	end if
end factorial

-- Check if the input is a valid number
try
	set num to userInput as integer
	if num < 0 then
		display dialog "Please enter a non-negative integer." buttons {"OK"} default button "OK"
	else
		set resultFactorial to factorial(num)
		display dialog resultFactorial buttons {"OK"} default button "OK"
	end if
on error
	display dialog "Please enter a valid integer." buttons {"OK"} default button "OK"
end try
