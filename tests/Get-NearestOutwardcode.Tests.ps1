# Pester Tests for Get-NearestPostcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-NearestOutwardcode' {
    It 'Given a valid geolocation it returns postcode data' {
        $result=Get-NearestOutwardCode -Latitude 51.50460 -Longitude -0.13217 -limit 1
        $result.Outcode | Should -Be 'SW1A'
    }
    It 'Given a non-postcoded location return multiple postcodes' {
        $result=Get-NearestOutwardCode -outcode "EC4M" | Select-Object outcode
        $result.count | Should -Be 10
    }
    It 'Given a gibberish outcode and using the alias should throw an error' {
         { Get-NearestOutCode -outcode "banana"} | Should -Throw -ExpectedMessage "Outcode not found"
    }
}