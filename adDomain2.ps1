param (

    [parameter(Mandatory = $true)]
    [string]
    $domainPassword
    
)

$domainName = "ent.bhicorp.com"

$ouPath = 'OU="Managed Servers - Azure",DC=ent,DC=bhicorp,DC=com'

$domainUsername = "BHI-MASTER\svc-BHazVMjoin"

Write-Host "##OUPATH VALUE IS: $ouPath"
Write-Host "##Domain Name value IS: $domainName"
Write-Host "##DomainUser Name IS: $domainUsername"

$domainPwd = $domainPassword | ConvertTo-SecureString -AsPlainText -Force

Write-Host "### Domain values--New-Object System.Management.Automation.PSCredential ($domainUsername, $domainPwd)"
$credential = New-Object pscredential ($domainUsername, $domainPwd)

Write-Host " #### -Credential : '$credential'"
## Add computer to Domain
Add-Computer -DomainName $domainName -OUPath $ouPath -Credential $credential

Write-Host "End of Domainjoin and local admin join"

## Add local admin to group
Add-LocalGroupMember -Group "Administrators" -Member "BHI-MASTER\BHCAzure_Officina2_Windows_HPA"
Add-LocalGroupMember -Group "Administrators" -Member "BHI-MASTER\BHCAzure_HPA_ALL"
Add-LocalGroupMember -Group "Administrators" -Member "BHI-MASTER\BHCAzure_Jivs_Windows_HPA_p"

## Write-Host "Waiting to restart with time"

## Start-Sleep -Seconds 10
## Write-Host "Restarting the system"

## Restart-Computer
