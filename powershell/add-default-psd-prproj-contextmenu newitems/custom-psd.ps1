# NOTE: don't forget to change permissions before running the script so that "administrators" are the "owner"
#         HKEY_CLASSES_ROOT (HKCR)       HKEY_CURRENT_CONFIG (HKCC)       HKEY_CURRENT_USER (HKCU)       HKEY_LOCAL_MACHINE (HKLM)        HKEY_USERS (HKU)
# Reg Add HKEY_CLASSES_ROOT\_____________ /ve /t REG_EXPAND_SZ /d NOWBLANK

$path = 'C:\Users\steven\proj\powershell\add-default-psd-prproj-contextmenu newitems\model_files\Untitled.psd'

# load binary
$bytes = Get-Content -Path $path -AsByteStream -Raw

# add to regedit, if exists remove or use set-itemproperty
New-ItemProperty -Path registry::HKEY_CLASSES_ROOT\.psd\ShellNew -PropertyType "Binary" -Name data -Value ([byte[]]($bytes))
