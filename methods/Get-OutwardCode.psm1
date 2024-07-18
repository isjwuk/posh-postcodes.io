$API_ROOT="https://api.postcodes.io"
<#
.SYNOPSIS
    Geolocation data for the centroid of the outward code specified.
.DESCRIPTION
    Geolocation (latitude and longitude) data for the centroid of the outward code specified. The outward code represents the first half of any postcode (separated by a space).
.EXAMPLE
    Test-MyTestFunction -Verbose #TODO Examples
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
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