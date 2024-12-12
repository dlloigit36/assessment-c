﻿$backFileName = Get-Date -UFormat "%Y%m%d-%H%M"
$sqlmiServer = "myubuntuvm12.local.net,31437"
$sqlmiUser = "arcadmin"
$sqlmiPassword = '1qaz@WSX3edc$RFV'
$db1 = "AdventureWorks2019"

$urlLocation = 'https://filecopyxyz222.blob.core.windows.net/ads-backup'
$sasToken = "'sp=racwdl&st=2023-04-04T02:40:07Z&se=2023-12-12T10:40:07Z&spr=https&sv=2021-12-02&sr=c&sig=1I7ryuCr1rKY0II4UyJvWEgL%2FUg7SHS34m%2BI8kh0EY8%3D'"

Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery;" `
-ServerInstance $sqlmiServer -Username $sqlmiUser -Password $sqlmiPassword

Invoke-Sqlcmd -Query "DROP CREDENTIAL [$urlLocation];" `
 -ServerInstance $sqlmiServer -Username $sqlmiUser -Password $sqlmiPassword

Invoke-Sqlcmd -Query "IF NOT EXISTS (SELECT * FROM sys.credentials WHERE name = '$urlLocation') `
CREATE CREDENTIAL [$urlLocation] `
   WITH IDENTITY = 'SHARED ACCESS SIGNATURE', ` 
   SECRET = $sasToken;" `
-ServerInstance $sqlmiServer -Username $sqlmiUser -Password $sqlmiPassword

Invoke-Sqlcmd -Query "BACKUP DATABASE $db1 `
TO URL = '$urlLocation/$db1-$backFileName.bak' with COPY_ONLY;" `
-ServerInstance $sqlmiServer -Username $sqlmiUser -Password $sqlmiPassword

Invoke-Sqlcmd -Query "SELECT GETDATE() AS TimeOfQuery;" `
-ServerInstance $sqlmiServer -Username $sqlmiUser -Password $sqlmiPassword