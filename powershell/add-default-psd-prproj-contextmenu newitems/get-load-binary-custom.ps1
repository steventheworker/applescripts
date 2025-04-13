$path = 'C:\Users\steven\proj\powershell\add-default-psd-prproj-contextmenu newitems\Untitled.png'

# load binary
$bytes = Get-Content -Path $path -AsByteStream -Raw

echo $bytes
