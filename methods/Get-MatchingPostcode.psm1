$API_ROOT="https://api.postcodes.io"
<#
.SYNOPSIS
    Submit a postcode query and receive a complete list of postcode matches and all associated postcode data.
.DESCRIPTION
    This is essentially a postcode search which prefix matches and returns postcodes in sorted order (case insensitive)
.EXAMPLE
    Get-MatchingPostcode -PostcodeStart "MK3 6E" | Select postcode
    Return the 9 postcodes that start "MK3 6E"
.EXAMPLE
    Get-MatchingPostcode -PostcodeStart "N1 " -limit 30 | Select postcode
    Return the first 30 postcodes (in alphabetical order) that have the N1 outcode
.EXAMPLE
    Get-MatchingPostcode -PostcodeStart "SW11 1A" -limit 20
    Return the 18 postcodes that start "SW11 1A" including all the associated details.
#>
function Get-MatchingPostcode {
  [CmdletBinding()]
  param(
        # Filters random postcodes by outcode. Returns null if invalid outcode.
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        [string]$PostcodeStart,
        #(not required) Limits number of postcodes matches to return. Defaults to 10. Needs to be less than 100.
        [Parameter(Mandatory=$false)]
        [ValidateRange(1,99)]
        [int]$limit=10
  )

  process {
    $result=Invoke-RestMethod -Uri "$API_ROOT/postcodes?query=$PostcodeStart&limit=$limit" -Method Get -SkipHttpErrorCheck
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
