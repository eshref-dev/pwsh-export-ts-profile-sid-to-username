Clear-Host
<#
  by Eshref Ismailov
  =====
  Sometimes need to see when users last logged on to the terminal server 
  Script, gets files older than N days and uploads to a csv file in a readable form
#>
$Path = "path\to\vhdx\files"
$PathToExport = "$env:APPDATA\$(-join ((65..90) + (97..122) | Get-Random -Count 5 | % {[char]$_})).csv"
$DaysOlder = 30

$num = 0
$Result = (Get-ChildItem -Path $Path -Filter "*.vhdx")
foreach ($item in $Result) {

    if ($item.LastWriteTime -ge (Get-Date).AddDays(-$DaysOlder)) {
        $num+=1
        $SID = ($item.name).Split('.')[0].TrimStart('UVHD-')
        Get-ADUser -Identity $SID | Select-Object Name, SamAccountName | Export-Csv -Path $PathToExport -Append -Encoding UTF8 -Delimiter ";"
    }
}
Write-Host -ForegroundColor Green "Number of users: $num `nFile saved to $PathToExport"
