$API_ROOT="https://api.postcodes.io"

<#
.SYNOPSIS
    Returns nearest postcodes for a given longitude and latitude, or a given postcode.
.DESCRIPTION
    Returns nearest postcodes for a given longitude and latitude, or a given postcode.
.NOTES
    
.LINK
    
.EXAMPLE
    Get-NearestPostcode -Latitude 51.5012 -Longitude -0.1419
    Return all the data associated with the postcode for the selected Latitude and Longitude.
.EXAMPLE
    (Get-NearestPostcode -Latitude 51.5012 -Longitude -0.1419).Postcode
    Return only the postcode for the selected Latitude and Longitude.
.EXAMPLE
    Get-NearestPostcode -Latitude 51.406207 -Longitude -0.337634 | Select Postcode, distance
    Return multiple nearby postcodes in the event of a non-postcoded location.
.EXAMPLE
    Get-NearestPostcode -Latitude 51.406207 -Longitude -0.337634 -limit 1
    Return the closest nearby postcode in the event of a non-postcoded location.
.EXAMPLE   
    Get-NearestPostcode -Latitude 51.506645 -Longitude 0.003015 -radius 250
    Use the radius parameter to look further afield for the nearest postcode.

#>
function Get-NearestPostcode  {
  [CmdletBinding()]
  param(
    #Longitude pf Geolocation to return postcodes for
    [Parameter(Mandatory, ParameterSetName="GeoLocation")]
    [float]$Latitude,
    #Latitude pf Geolocation to return postcodes for
    [Parameter(Mandatory, ParameterSetName="GeoLocation")]
    [float]$Longitude,
    #(not required) Limits number of postcodes matches to return. Defaults to 10. Needs to be less than 100.
    [Parameter(Mandatory=$false, ParameterSetName="GeoLocation")]
    [ValidateRange(1,99)]
    [int]$limit=10,
    #(not required) Limits number of postcodes matches to return. Defaults to 100m. Needs to be less than 2,000m.
    [Parameter(Mandatory=$false, ParameterSetName="GeoLocation")]
    [ValidateRange(1,1999)]
    [int]$radius=100,
    #(not required) Search up to 20km radius, but subject to a maximum of 10 results. Since lookups over a wide area can be very expensive, we've created this method to allow you choose to make the trade off between search radius and number of results. Defaults to false. When enabled, radius and limits over 10 are ignored.
    [Parameter(Mandatory=$false, ParameterSetName="GeoLocation")]
    [switch]$widesearch
  )

  process {
    #Decide which API to use based on the Parameter set used when calling this function
    switch ($PSCmdlet.ParameterSetName) {
        'GeoLocation' {
            $URI="$API_ROOT/postcodes/?lon=$longitude&lat=$latitude&limit=$limit&radius=$radius"
            if ($widesearch ){$URI+="&widesearch=true"} # Add the Widesearch parameter if selected.
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
