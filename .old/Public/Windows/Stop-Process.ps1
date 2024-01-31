<#
.SYNOPSIS
This function takes in one or more System.Diagnostics.Process objects as input and terminates them by calling the Kill method on each process. The input can be provided through the pipeline.     
#>
function Stop-Process {
    param(
        [Parameter(ValueFromPipeline = $true)]
        [System.Diagnostics.Process]$Process
    )
    $Process | Foreach-Object {
        $_.Kill()
    }
}
