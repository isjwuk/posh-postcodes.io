$API_ROOT="https://api.postcodes.io"

<#
.SYNOPSIS
    Returns a random postcode and all available data for that postcode.
.DESCRIPTION
    Returns a random postcode and all available data for that postcode.
.EXAMPLE
    Get-RandomPostcode
    Returns a random postcode and all available data for that postcode.
.EXAMPLE
    Get-RandomPostcode -Outcode 'SW19'
    Returns a random postcode with the Outcode SW11 and all available data for that postcode.
.EXAMPLE
    'GU1','GU2' | Get-RandomPostcode
    Returns poscode data for a random postcode from each of the GU1 and GU2 outcodes.
#>
function Get-RandomPostcode  {
    [CmdletBinding()]
    param(
        #(not required) Filters random postcodes by outcode. Returns null if invalid outcode.
        [Parameter(Mandatory=$false,ValueFromPipeline=$true)]
        [string]$outcode
    )

    process {
        $result=Invoke-RestMethod -Uri "$API_ROOT/random/postcodes?outcode=$outcode" -Method Get -SkipHttpErrorCheck
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