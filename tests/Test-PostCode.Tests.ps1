# Pester Tests for Test-Postcode
BeforeAll {
    Import-Module $PSScriptRoot/../Posh-Postcodes.io.psd1
}
Describe 'Test-Postcode' {
    It 'Given a valid postcode it returns true' {
        $result=Test-Postcode -Postcode 'SW1A 1AA'
        $result | Should -Be $true
    }
    It 'Given a nonsense postcode it returns false' {
        $result=Test-Postcode -Postcode 'Banana'
        $result | Should -Be $false
    }
    It 'Given two postcodes on the pipeline, one valid and one not, it returns true and false' {
        $result='EH99 1SP','Banana' | Test-Postcode
        $result | Should -Be ($true, $false)
    }
    It 'Given a valid postcode with mixed case and no space it returns true'{
        $result=Test-Postcode -Postcode "Cf991sn"
        $result | Should -Be $true
    }

}