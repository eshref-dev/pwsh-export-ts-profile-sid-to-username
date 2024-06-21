Clear-Host
<#
  by Eshref Ismailov
  На случай, если у вас по каким-то "не известным" причинам начало все тормозить.
  Возможно, в вашей инфраструктуре используется dlp система "Стахановец (stakhanovets dlp)"
  проверить можно следующей командой:
    Запустить powershell от имени администратора
    Get-WmiObject -Class win32_service |Where-Object {$_.name -eq "StkhClientService"}
#>
$ProcessName = "StkhClientService"
$service = Get-WmiObject -Class win32_service |Where-Object {$_.name -like "*$($ProcessName.ToLower())*"}
if ($service) {
    Write-Host -ForegroundColor Green "Mark service to Delete: $($service.Name)" 
    $service.Delete() 
    Write-Host -ForegroundColor Green "Stop Process: $($service.Name) with id: $($service.ProcessId)" 
    Stop-Process -Id $($service.ProcessId) -Confirm:$false
    Write-Host -ForegroundColor Green "Please reboot the computer"
} else {
    Write-Host -ForegroundColor Red "Process with name: $ProcessName not found" 
}
