# NOTE: don't forget to change permissions before running the script so that "administrators" are the "owner"
 
$key = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Connections'
$data = (Get-ItemProperty -Path $key -Name DefaultConnectionSettings).DefaultConnectionSettings
# Set-ItemProperty -Path $key -Name DefaultConnectionSettings -Value $data
echo $data
