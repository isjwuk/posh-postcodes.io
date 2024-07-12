$API_ROOT="https://api.postcodes.io"

<#
.SYNOPSIS
    Returns nearest postcodes for a given longitude and latitude, or a given postcode.
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    (Get-NearestPostcode -Latitude 51.5012 -Longitude -0.1419).Postcode
    Return the postcode for the selected Latitude and Longitude
#>
function Get-NearestPostcode  {
  [CmdletBinding()]
  param(
    #Longitude pf Geolocation to return postcodes for
    [Parameter(Mandatory, ParameterSetName="GeoLocation")]
    [float]$Latitude,
    #Latitude pf Geolocation to return postcodes for
    [Parameter(Mandatory, ParameterSetName="GeoLocation")]
    [float]$Longitude
  )

  process {
    #Decide which API to use based on the Parameter set used when calling this function
    switch ($PSCmdlet.ParameterSetName) {
        'GeoLocation' {
            $result=Invoke-RestMethod -Uri "$API_ROOT/postcodes/?lon=$longitude&lat=$latitude" -Method Get -SkipHttpErrorCheck
        }
    }
    switch ($result.status) {
        200 {
            $result.result 
            }
        Default {
            throw $result.error
        }
    }
  
  }
}
