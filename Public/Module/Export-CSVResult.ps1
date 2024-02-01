function Export-CSVResult {
    param (
        [string]$functionName
    )

    $scriptBlock = Get-Command $functionName | Select-Object -ExpandProperty ScriptBlock

    if ($scriptBlock -eq $null) {
        Write-Output "Function $functionName not found."
        return
    }

    $functions = $scriptBlock | Where-Object { $_ -is [System.Management.Automation.Language.FunctionDefinitionAst] }

    if ($functions.Count -eq 0) {
        Write-Output "No functions found within $functionName."
        return
    }

    $results = @{}

    foreach ($function in $functions) {
        $functionName = $function.Name
        $data = Invoke-Expression "$functionName"
        $defaultPath = "C:\temp\$functionName.csv"
        $filePath = $defaultPath

        $data | Export-Csv -Path $filePath -NoTypeInformation
        Write-Output "Results for $functionName exported to $filePath"
        $results[$functionName] = $filePath
    }

    Write-Output "All results exported successfully."

    $ReturnMenu = Read-Host "Return to main menu? (Y/N)"
    if ($ReturnMenu -eq "Y") {
        Show-Menu
    }
    else {
        exit
    }
}
