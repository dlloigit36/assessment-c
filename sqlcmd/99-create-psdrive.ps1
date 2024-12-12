
##https://learn.microsoft.com/en-us/sql/powershell/manage-authentication-in-database-engine-powershell?view=sql-server-ver16
## Create a function that specifies the login and prompts for the password.  
  
function sqldrive  
{  
    param( 
        [string]$name, 
        [string]$login = "arcadmin", 
        [string]$root = "SQLSERVER:\SQL\myubuntuvm12.local.net,31437\DEFAULT" )  
    $pwd = read-host -AsSecureString -Prompt "Password"  
    $cred = new-object System.Management.Automation.PSCredential -argumentlist $login,$pwd  
    New-PSDrive $name -PSProvider SqlServer -Root $root -Credential $cred -Scope 1  
}  
  
## Use the sqldrive function to create a SQLAuth virtual drive.  
sqldrive SQLAuth
  
## Set-Location to the virtual drive, which invokes the supplied authentication credentials.  
sl SQLAuth:

####my modified command to run manually--
##run powershell as administrator
Install-Module -Name SqlServer

import-Module -Name SqlServer

$pwd = read-host -AsSecureString -Prompt "Password" 
$cred = new-object System.Management.Automation.PSCredential -argumentlist arcadmin,$pwd

New-PSDrive ARCADS -PSProvider SqlServer -Root "SQLSERVER:\SQL\myubuntuvm12.local.net,31437\DEFAULT" -Credential $cred -Scope 1 

Set-Location ARCADS
#cd to sql server and get instances
$sqlPath = "SQLSERVER:\SQL\myubuntuvm12.local.net,31437\DEFAULT"
cd $sqlPath
$instances = Get-ChildItem

##https://learn.microsoft.com/en-us/sql/relational-databases/backup-restore/back-up-multiple-databases-to-azure-blob-storage-powershell?view=sql-server-ver16
# set parameters
##$sqlPath = "sqlserver:\sql\$($env:COMPUTERNAME)"
$storageAccount = "<myStorageAccount>"  
$storageKey = "<myStorageAccessKey>"  
$secureString = ConvertTo-SecureString $storageKey -AsPlainText -Force  
$credentialName = "myCredential-$(Get-Random)"

Write-Host "Generate credential: " $credentialName

#loop through instances and create a SQL credential, output any errors
foreach ($instance in $instances)  {
    try {
        $path = "$($sqlPath)\$($instance.DisplayName)\credentials"
        New-SqlCredential -Name $credentialName -Identity $storageAccount -Secret $secureString -Path $path -ea Stop | Out-Null
        Write-Host "...generated credential $($path)\$($credentialName)."  }
    catch { Write-Host $_.Exception.Message } }
##The statement -ea Stop | Out-Null is used for user-defined exception output. 
##If you prefer default PowerShell error messages, this statement can be removed.

###----yet to try
#do install-module sqlserver if get module sqlserver return no result
get-module sqlserver -ListAvailable
import-Module -Name SqlServer

##create sqlserver new drive
$pwd = read-host -AsSecureString -Prompt "Password" 
$cred = new-object System.Management.Automation.PSCredential -argumentlist arcadmin,$pwd
New-PSDrive ARCADS -PSProvider SqlServer -Root "SQLSERVER:\SQL\myubuntuvm12.local.net,31437\DEFAULT" -Credential $cred

$sqlPath = "SQLSERVER:\SQL\myubuntuvm12.local.net,31437\DEFAULT"
$credentialName = "https://filecopyxyz222.blob.core.windows.net/ads-backup"
$identity = "SHARED ACCESS SIGNATURE"
$secureString = "sp=racwdl&st=2023-03-28T03:06:34Z&se=2023-06-28T11:06:34Z&spr=https&sv=2021-12-02&sr=c&sig=x%2BG%2B2REiF6b0ocxbVN71R8DB0fU21z8Ll%2FNHiOMEDIY%3D"
$credpath = "$($sqlPath)\credentials"
New-SqlCredential -Name $credentialName -Identity $identity -Secret $secureString -Path $credpath -ea Stop | Out-Null

##delete credential
Remove-SqlCredential -Path "$($credpath)\$($credentialName)" -ea Stop | Out-Null

Remove-SqlCredential -Path "SQLSERVER:\SQL\Computer\Instance\Credentials\MySqlCredential"