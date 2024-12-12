$file = 'c:\temp\host-rules00xx.json' ##file not exist
$itemexist = Get-Item -Path $file
$itemexist2 = Get-ChildItem -Path $file

if (-not(Test-Path -Path $file -PathType Leaf)) {
     try {
         $null = New-Item -ItemType File -Path $file -Force -ErrorAction Stop
         Write-Host "The file [$file] has been created."
     }
     catch {
         throw $_.Exception.Message
     }
 } else {
    Write-Host "The file [$file] already exist"
    ##delete file
    ##create it
}


##return result The file [c:\temp\host-rules00xx.json] has been created

##method 2
if (-not($itemexist)) {
    try {
        $null = New-Item -ItemType File -Path $file -Force -ErrorAction Stop
        Write-Host "The file [$file] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Write-Host "The file [$file] already exist"
}

##method 3
if (-not($itemexist2)) {
    try {
        $null = New-Item -ItemType File -Path $file -Force -ErrorAction Stop
        Write-Host "The file [$file] has been created."
    }
    catch {
        throw $_.Exception.Message
    }
} else {
    Write-Host "The file [$file] already exist"
}

