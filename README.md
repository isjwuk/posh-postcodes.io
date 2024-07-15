# posh-postcodes.io
A PowerShell wrapper for the postcodes.io API used for working with UK postcode data

![PowerShell](https://img.shields.io/badge/PowerShell-%235391FE.svg?style=for-the-badge&logo=powershell&logoColor=white)

## Postcodes.io
>[Postcodes.io](https://postcodes.io/) is an open sourced project maintained by Ideal Postcodes.
>It is a free resource, allowing developers to search, reverse geocode and extract UK postcode and associated data.

## Example Usage

### Install and Import the module
```powershell
Install-Module Posh-Postcodes.io 
```

```powershell
Import-Module Posh-Postcodes.io
```

### Lookup a Postcode
The following example will return information associated with the postcode ``L4 0TH``.
```powershell
Get-PostcodeInfo -Postcode 'L4 0TH'

postcode                        : L4 0TH
quality                         : 1
eastings                        : 336209
northings                       : 393151
country                         : England
nhs_ha                          : North West
longitude                       : -2.961584
latitude                        : 53.431267
european_electoral_region       : North West
primary_care_trust              : Liverpool
region                          : North West
lsoa                            : Liverpool 018A
msoa                            : Liverpool 018
incode                          : 0TH
outcode                         : L4
parliamentary_constituency      : Liverpool, Walton
parliamentary_constituency_2024 : Liverpool Riverside
admin_district                  : Liverpool
parish                          : Liverpool, unparished area
admin_county                    :
date_of_introduction            : 198001
admin_ward                      : Anfield
ced                             :
ccg                             : NHS Cheshire and Merseyside
nuts                            : Liverpool
pfa                             : Merseyside
codes                           : @{admin_district=E08000012;
                                    admin_county=E99999999; 
                                    admin_ward=E05015279;
                                    parish=E43000166;
                                    parliamentary_constituency=E14000794;
                                    parliamentary_constituency_2024=E14001338;
                                    ccg=E38000101;
                                    ccg_id=99A;
                                    ced=E99999999;
                                    nuts=TLD72;
                                    lsoa=E01006542;
                                    msoa=E02001364;
                                    lau2=E08000012;
                                    pfa=E23000004}
```

### Get-Help

Full descriptions and examples are available through ``Get-Help``, for example

```powershell
Get-Help Get-PostcodeInfo -Examples
Get-Help Test-Postcode
Get-Help Get-NearestPostcode -ShowWindow
```

## Testing
Pester is used for unit testing.
```powershell
Invoke-Pester .\tests\*.Tests.ps1 -Output detailed
``` 

PSScriptAnalyzer is used for identifying common issues
```powershell
Invoke-ScriptAnalyzer -Path .\Posh-Postcodes.io.psd1
Invoke-ScriptAnalyzer -Path .\methods\*.psm1
```