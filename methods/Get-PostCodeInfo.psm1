$API_ROOT="https://api.postcodes.io"

<#
.SYNOPSIS
    Returns a single postcode entity for a given postcode.
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Get-PostCodeInfo -Postcode 'SW1A 1AA'
    Return the information associated with the Postcode SW1A 1AA
.EXAMPLE
    "CF991SN", "SW1a 1aa" | Get-PostCodeInfo
    Return the information associated with the two Postcodes passed via the pipeline.
#>

function Get-PostCodeInfo {
    param (
        #Postcode to Lookup. Required string. Case and space insensitive, examples 'SW1A 1AA', 'CF991SN'
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
            [string] $Postcode
    )
    Process {
        $result=Invoke-RestMethod -Uri "$API_ROOT/postcodes/$Postcode" -Method Get -SkipHttpErrorCheck
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
