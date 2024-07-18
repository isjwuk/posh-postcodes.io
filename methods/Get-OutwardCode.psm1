$API_ROOT="https://api.postcodes.io"
<#
.SYNOPSIS
    Geolocation data for the centroid of the outward code specified.
.DESCRIPTION
    Geolocation (latitude and longitude) data for the centroid of the outward code specified. The outward code represents the first half of any postcode (separated by a space).
.EXAMPLE
    Get-OutwardCode "GU1"
    Return the full geolocation data for the Outward code "GU1"
.EXAMPLE
    Get-OutwardCode "SW19" | Select-Object Latitude, Longitude
    Get the latitude and longitude for the centroid of the Outcode SW19.
#>
function Get-OutwardCode {
    [alias("Get-OutCode")]
    [CmdletBinding()]
    param(
      #Return geolocation results for this Outward Code
      [Parameter(Mandatory, ParameterSetName="Outcode", Position=0)]
      [string]$outcode
    )
    process {
        $URI="$API_ROOT/outcodes/$outcode"
        $result=Invoke-RestMethod -Uri $URI -Method Get -SkipHttpErrorCheck
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