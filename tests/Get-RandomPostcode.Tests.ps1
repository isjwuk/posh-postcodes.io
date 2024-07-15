# Pester Tests for Get-RandomPostcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-RandomPostcode' {
    It 'Given no arguments returns postcode data' {
        $result=Get-RandomPostcode 
        $result.count | Should -Be 1
    }
    It 'Given two valid outcode on the pipeline, it returns values for both' {
        $result='GU1','GU2' | Get-RandomPostcode
        $result[0].country + $result[1].country | Should -Be 'EnglandEngland'
    }
    It 'Given a valid outcode passed via parameter it returns postcode data'{
        $result=Get-RandomPostcode -Outcode 'SW19'
        $result.region | Should -Be 'London'
        $result.count | Should -Be 1
        $result.outcode | Should -Be 'SW19'
    }

}