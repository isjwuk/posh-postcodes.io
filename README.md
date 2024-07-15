# posh-postcodes.io
A PowerShell wrapper for the postcodes.io API used for working with UK postcode data

## Postcodes.io
>[Postcodes.io](https://postcodes.io/) is an open sourced project maintained by Ideal Postcodes.
>It is a free resource, allowing developers to search, reverse geocode and extract UK postcode and associated data.

## Testing
Pester is used for testing.
```powershell
Invoke-Pester .\tests\*.Tests.ps1
``` 

PSScriptAnalyzer is used for identifying common issues
```powershell
Invoke-ScriptAnalyzer -Path .\Posh-Postcodes.io.psd1
Invoke-ScriptAnalyzer -Path .\methods\*.psm1
```