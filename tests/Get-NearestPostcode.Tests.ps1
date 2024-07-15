# Pester Tests for Get-NearestPostcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-NearestPostcode' {
    It 'Given a valid geolocation it returns postcode data' {
        $result=Get-NearestPostcode -Latitude 51.5012 -Longitude -0.1419
        $result.Postcode | Should -Be 'SW1A 1AA'
    }
    It 'Given a non-postcoded location return multiple postcodes' {
        $result=Get-NearestPostcode -Latitude 51.406207 -Longitude -0.337634
        $result.count | Should -Be 4
    }
    It 'Given a non-postcoded location return multiple postcodes but use the limit parameter' {
        $result=Get-NearestPostcode -Latitude 51.406207 -Longitude -0.337634 -limit 2
        $result.count | Should -Be 2
    }
    It 'Given a non-postcoded location return the postcodes using the range parameter' {
        $result=Get-NearestPostcode -Latitude 51.506645 -Longitude 0.003015 
        $result | Should -Be $null
        $result=Get-NearestPostcode -Latitude 51.506645 -Longitude 0.003015 -radius 250
        $result.count | Should -Be 2
    }
    It 'Given a postcode return the nearest postcodes' {
        $result=Get-NearestPostcode -postcode 'EC4M 8AD' | Select-Object postcode
        $result.count | Should -Be 10
    }
    It 'Given a postcode return the nearest postcodes but require the radius parameter to get results' {
        $result=Get-NearestPostcode -postcode 'SE10 0DX' | Select-Object postcode
        $result.count | Should -Be 1
        $result=Get-NearestPostcode -postcode 'SE10 0DX' -radius 250| Select-Object postcode
        $result.count | Should -Be 7
    }
}