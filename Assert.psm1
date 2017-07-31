Import-Module $PSScriptRoot\TypeClass\src\TypeClass.psm1
Import-Module $PSScriptRoot\Format\src\Format.psm1

. $PSScriptRoot\Compatibility\src\New-PSObject.ps1

Get-ChildItem -Path $PSScriptRoot\src\ -Recurse -Filter *.ps1 | 
    foreach { . $_.FullName }

Export-ModuleMember -Function Assert-Equivalent, 
    Assert-Equal, # ?= , ?eq
    Assert-NotEqual, # ?!= ?ne
    Assert-Same, # ?=== ?ref ?same 
    Assert-NotSame, # ?!=== ?notref ?notsame
    Assert-Null, # ?0  ?null
    Assert-NotNull, # ?!0  ?notnull
    Assert-Type, # ?type ?is
    Assert-NotType, # ?nottype ?isnot
    Assert-LessThan, # ?< ?lt
    Assert-LessThanOrEqual, # ?<= ?le
    Assert-GreaterThan, # ?> ?gt
    Assert-GreaterThanOrEqual, # ?>= ?ge,
    Assert-True, # ?true
    Assert-False, # ?false
    Assert-CollectionContain, # ?contain
    Assert-CollectionNotContain, #?notcontain
    Assert-CollectionAny # ?any