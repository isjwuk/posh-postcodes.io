# Pester Tests for Get-OutwardCode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Get-NearestOutwardcode' {
    It 'Given a valid outcode and the alias cmdlet with positional parameter it returns valid data' {
        $result=get-outcode "GU1"
        $result.Admin_district | Should -Be 'Guildford'
    }
    It 'Given a gibberish outcode it should throw an error' {
         { Get-OutwardCode -outcode "banana"} | Should -Throw -ExpectedMessage "Outcode not found"
    }
}