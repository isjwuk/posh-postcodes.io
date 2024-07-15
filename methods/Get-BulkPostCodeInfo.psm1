#TODO Complete this function
<#
.SYNOPSIS
    Returns a list of matching postcodes and respective available data.
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Accepts up to 100 postcodes
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
function Get-BulkPostcodeInfo {
  [CmdletBinding()]
  param(
        #Postcodes to Lookup. Required string. Case and space insensitive, examples 'SW1A 1AA', 'CF991SN'
        #[Parameter(Mandatory=$true,ValueFromPipeline=$true)]
        #    [string()] $Postcodes
  )

  process {
    #TODO
  }
}