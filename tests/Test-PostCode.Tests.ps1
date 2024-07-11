# Pester Tests for Test-PostCode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Test-PostCode' {
    It 'Given a valid postcode it returns true' {
        $result=Test-PostCode -Postcode 'SW1A 1AA'
        $result | Should -Be $true
    }
    It 'Given a nonsense postcode it returns false' {
        $result=Test-PostCode -Postcode 'Banana'
        $result | Should -Be $false
    }
    It 'Given two postcodes on the pipeline, one valid and one not, it returns true and false' {
        $result='EH99 1SP','Banana' | Test-PostCode
        $result | Should -Be ($true, $false)
    }
    It 'Given a valid postcode with mixed case and no space it returns true'{
        $result=Test-PostCode -Postcode "Cf991sn"
        $result | Should -Be $true
    }

}