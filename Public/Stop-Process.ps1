function Stop-Process {
    param(
        [Parameter(ValueFromPipeline = $true)]
        [System.Diagnostics.Process]$Process
    )

    $Process | Foreach-Object {
        $_.Kill()
    }
    Show-Menu
}
