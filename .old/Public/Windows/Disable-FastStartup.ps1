<#
.SYNOPSIS
Disables Windows fast startup.
#>
function Disable-FastStartup() {
    $RegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
    $RegName = "HiberbootEnabled"
    $RegValue = "0"

    If ((Test-Path -LiteralPath $RegPath) -ne $true) {
        New-Item $RegPath -Force -ea SilentlyContinue
    }
    New-ItemProperty -LiteralPath $RegPath -Name $RegName -Value $RegValue -PropertyType DWORD -Force -ea SilentlyContinue
}