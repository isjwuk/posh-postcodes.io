# Pester Tests for Get-PostcodeInfo
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-PostcodeInfo' {
    It 'Given a valid postcode it returns postcode data' {
        $result=Get-PostcodeInfo -Postcode 'SW1A 1AA'
        $result.country | Should -Be 'England'
    }
    It 'Given a nonsense postcode it returns an Invalid Postcode error' {
        { Get-PostcodeInfo -Postcode 'Banana'} | Should -Throw -ExpectedMessage "Invalid postcode"
    }
    It 'Given two valid postcodes on the pipeline, it returns values for both' {
        $result='EH99 1SP','SW1A 1AA' | Get-PostcodeInfo
        $result[0].country + $result[1].country | Should -Be 'ScotlandEngland'
    }
    It 'Given a valid postcode with mixed case and no space it returns data'{
        $result=Get-PostcodeInfo -Postcode "Cf991sn"
        $result.Country | Should -Be 'Wales'
    }

}