#Credenciales de acceso
$user = "user@domain.com"
$password = ConvertTo-SecureString "password" -AsPlainText -Force  
$credential = New-Object System.Management.Automation.PSCredential ($user, $password)
Connect-MsolService -Credential $credential

#Obtención de licencias de usuario y filtrado por Power BI Pro
$users=(Get-MsolUser -EnabledFilter EnabledOnly -MaxResults 2000 | Where-Object {$_.licenses.AccountSkuId -like "*POWER_BI_PRO*"})

#Variables
$path = "C:\path\"
$file="file.csv"
$filepath=$path+$file
$delimited = ";"
$head="`"UserPrincipalName`""

#Setea la cabecera del CSV
Set-Content -Path  $filepath -Value $head

#Itera los usuarios y los almacena en CSV
Foreach ($user in $users)
{	
	$record = $user.UserPrincipalName		
	Add-Content -Path $filepath  -Value $record
}

