# Pester Tests for Get-MatchingPostcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-MatchingPostcode' {
    It 'Given a full postcode returns postcode data for that postcode' {
        $result=Get-MatchingPostcode -PostcodeStart 'SW1A 1AA'
        $result.count | Should -Be 1
    }
    It 'Given a partial postcode returns postcode data for many postcodes' {
        $result=Get-MatchingPostcode -PostcodeStart 'SW1A 1A'
        $result.count | Should -Be 4
    }
    It 'Given two valid outcode on the pipeline, it returns values for both' {
        $result='GU2 7X','GU2 7Y' | Get-MatchingPostcode -limit 20
        $result.count | Should -Be 24
    }
    It 'Given a nonsense partial it returns no data'{
        $result=Get-MatchingPostcode -PostcodeStart 'banana'
        $result | Should -Be $null
    }

}