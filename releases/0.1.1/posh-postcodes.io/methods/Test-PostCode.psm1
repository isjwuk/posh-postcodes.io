$API_ROOT="https://api.postcodes.io"

<#
.SYNOPSIS
    Convenience method to validate a postcode.
.DESCRIPTION
    Returns true if the given postcode is valid, otherwise false
.EXAMPLE
    Test-Postcode -Postcode "EH99 1SP"
    (or    Test-Postcode -Postcode "EH991sp"  )
    Validate the Postcode EH99 1SP. This returns true for both as the postcode is valid and the function is case and space insensitive.
.EXAMPLE
    Test-Postcode -Postcode "Banana"
    Returns False as this postcode is very, very invalid.
.EXAMPLE
    "GU1 1AA", "GU1 1AB", "GU1 1AC", "GU1 1AD"  | Test-Postcode
    Validates each of these four correct-looking postcodes. The result is
        True
        False
        False
        True
    As the first and fourth postcodes are valid and the middle two, despite being the correct format, don't exist in the database.
#>
function Test-Postcode {
    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        #Postcode to Validate. Required string. Case and space insensitive, examples 'SW1A 1AA', 'CF991SN'
        [Parameter(Mandatory=$true,ValueFromPipeline=$true)]
            [string] $Postcode
    )

    process {
        $result=Invoke-RestMethod -Uri "$API_ROOT/postcodes/$Postcode/validate" -Method Get -SkipHttpErrorCheck
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