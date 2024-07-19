  $API_ROOT="https://api.postcodes.io"
<#
.SYNOPSIS
    Returns nearest outcodes for a given longitude and latitude or a given Outcode
.DESCRIPTION
    Returns nearest outward codes for a given longitude and latitude or a given Outward code
.EXAMPLE
    Get-NearestOutwardCode -outcode "EC4M" | Select-Object outcode
    Return the nearest outward codes to the given outcode.
.EXAMPLE
    Get-NearestOutwardCode -Latitude 51.50460 -Longitude -0.13217 -limit 1
    Return all the data associated with the nearest outcode for the selected Latitude and Longitude.
#>
function Get-NearestOutwardCode {
    [alias("Get-NearestOutCode")]
    [CmdletBinding()]
    param(
      #Return nearest results for this Outward Code
      [Parameter(Mandatory, ParameterSetName="Outcode")]
      [string]$outcode,
      #Longitude pf Geolocation to return postcodes for
      [Parameter(Mandatory, ParameterSetName="GeoLocation")]
      [float]$Latitude,
      #Latitude pf Geolocation to return postcodes for
      [Parameter(Mandatory, ParameterSetName="GeoLocation")]
      [float]$Longitude,
      #(not required) Limits number of postcodes matches to return. Defaults to 10. Needs to be less than 100.
      [Parameter(Mandatory=$false, ParameterSetName="GeoLocation")]
      [Parameter(Mandatory=$false, ParameterSetName="Outcode")]
      [ValidateRange(1,99)]
      [int]$limit=10,
      #(not required) Limits number of postcodes matches to return. Defaults to 5000m. Needs to be less than 25,000m.
      [Parameter(Mandatory=$false, ParameterSetName="GeoLocation")]
      [Parameter(Mandatory=$false, ParameterSetName="Outcode")]
      [ValidateRange(1,24999)]
      [int]$radius=5000
    )

    process {
      #Decide which API to use based on the Parameter set used when calling this function
      switch ($PSCmdlet.ParameterSetName) {
          'GeoLocation' {
              $URI="$API_ROOT/outcodes/?lon=$longitude&lat=$latitude&limit=$limit&radius=$radius"
              $result=Invoke-RestMethod -Uri $URI -Method Get -SkipHttpErrorCheck
          }
          'Outcode' {
              $URI="$API_ROOT/outcodes/$outcode/nearest?limit=$limit&radius=$radius"
              $result=Invoke-RestMethod -Uri $URI -Method Get -SkipHttpErrorCheck
          }
      }
      #Return the results
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



