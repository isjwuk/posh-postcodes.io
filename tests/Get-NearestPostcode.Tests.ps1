# Pester Tests for Get-NearestPostcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-NearestPostcode' {
    It 'Given a valid geolocation it returns postcode data' {
        $result=Get-NearestPostcode -Latitude 51.5012 -Longitude -0.1419
        $result.Postcode | Should -Be 'SW1A 1AA'
    }
    # It 'Given a nonsense postcode it returns an Invalid Postcode error' {
    #     { Get-PostCodeInfo -Postcode 'Banana'} | Should -Throw -ExpectedMessage "Invalid postcode"
    # }
    # It 'Given two valid postcodes on the pipeline, it returns values for both' {
    #     $result='EH99 1SP','SW1A 1AA' | Get-PostCodeInfo
    #     $result[0].country + $result[1].country | Should -Be 'ScotlandEngland'
    # }
    # It 'Given a valid postcode with mixed case and no space it returns data'{
    #     $result=Get-PostCodeInfo -Postcode "Cf991sn"
    #     $result.Country | Should -Be 'Wales'
    # }

}