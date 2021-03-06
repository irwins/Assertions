 InModuleScope -ModuleName Assert {
    Describe "Format-Collection" { 
        It "Formats collection of values '<value>' to '<expected>' using the default separator" -TestCases @(
            @{ Value = (1,2,3); Expected = "1, 2, 3" }
        ) { 
            param ($Value, $Expected)
            Format-Collection -Value $Value | Verify-Equal $Expected
        }

        It "Formats collection of values '<value>' to '<expected>' using the default separator" -TestCases @(
            @{ Value = (1,2,3); Expected = "1, 2, 3" }
        ) { 
            param ($Value, $Expected)
            Format-Collection -Value $Value | Verify-Equal $Expected
        }
    }

    Describe "Format-Number" { 
        It "Formats number to use . separator (tests anything only on non-english systems --todo)" -TestCases @(
            @{ Value = 1.1; },
            @{ Value = [double] 1.1; },
            @{ Value = [float] 1.1; },
            @{ Value = [single] 1.1; },
            @{ Value = [decimal] 1.1; }
        ) { 
            param ($Value)
            Format-Number -Value $Value | Verify-Equal "1.1"
        }
    }

    Describe "Format-Object" {
        It "Formats object '<value>' to '<expected>'" -TestCases @(
            @{ Value = (New-PSObject @{Name = 'Jakub'; Age = 28}); Expected = "PSObject{Age=28; Name=Jakub}"},
            @{ Value = (New-Object -Type Assertions.TestType.Person -Property @{Name = 'Jakub'; Age = 28}); Expected = "Assertions.TestType.Person{Age=28; Name=Jakub}"}
        ) { 
            param ($Value, $Expected)
            Format-Object -Value $Value | Verify-Equal $Expected
        }

        It "Formats object '<value>' with selected properties '<selectedProperties>' to '<expected>'" -TestCases @(
            @{ Value = (New-PSObject @{Name = 'Jakub'; Age = 28}); SelectedProperties = "Age"; Expected = "PSObject{Age=28}"},
            @{ Value = (Get-Process -Name Idle); SelectedProperties = 'Name','Id'; Expected = "Diagnostics.Process{Id=0; Name=Idle}" },
            @{ 
                Value = (New-Object -Type Assertions.TestType.Person -Property @{Name = 'Jakub'; Age = 28})
                SelectedProperties = 'Name'
                Expected = "Assertions.TestType.Person{Name=Jakub}"}
        ) { 
            param ($Value, $SelectedProperties, $Expected)
            Format-Object -Value $Value -Property $SelectedProperties | Verify-Equal $Expected
        }
    }

    Describe "Format-Boolean" {
        It "Formats boolean '<value>' to '<expected>'" -TestCases @(
            @{ Value = $true; Expected = '$true' },
            @{ Value = $false; Expected = '$false' }
        ) {
            param($Value, $Expected)
            Format-Boolean -Value $Value | Verify-Equal $Expected
        }
    }

    Describe "Format-Null" { 
        It "Formats null to '`$null'" {
            Format-Null | Verify-Equal '$null'
        }
    }

    Describe "Format-ScriptBlock" { 
        It "Formats scriptblock as string with curly braces" {
            Format-ScriptBlock -Value {abc} | Verify-Equal '{abc}'
        }
    }

    Describe "Format-Custom" {
        It "Formats value '<value>' correctly to '<expected>'" -TestCases @(
            @{ Value = $null; Expected = '$null'}
            @{ Value = $true; Expected = '$true'}
            @{ Value = $false; Expected = '$false'}
            @{ Value = 'a' ; Expected = 'a'},
            @{ Value = 1; Expected = '1' },
            @{ Value = (1,2,3); Expected = '1, 2, 3' },
            @{ Value = 1.1; Expected = '1.1' },
            @{ Value = New-PSObject @{ Name = "Jakub" }; Expected = 'PSObject{Name=Jakub}' },
            @{ Value = (Get-Process Idle); Expected = 'Diagnostics.Process{Id=0; Name=Idle}'},
            @{ Value = (New-Object -Type Assertions.TestType.Person -Property @{Name = 'Jakub'; Age = 28}); Expected = "Assertions.TestType.Person{Age=28; Name=Jakub}"}
        ) { 
            param($Value, $Expected)
            Format-Custom -Value $Value | Verify-Equal $Expected
        }
    }
 }
 