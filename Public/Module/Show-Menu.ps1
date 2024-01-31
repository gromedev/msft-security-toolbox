function Show-Menu {

    Write-Host "`n"

    $menuOptions = @{
        <#
        "1" = { Show-MenuDefender }
        "2" = { Show-MenuWindows }
        "3" = { Show-MenuAZ }
        "4" = { Show-MenuNetworking }
        "5" = { Show-MenuSearch }
#>
        "6" = { Show-MenuCIS }

        "7" = { Write-Host "Quitting..."; exit }
    }

    $menuDescriptions = @{
        <#
        "1" = "Defender"
        "2" = "Windows OS"
        "3" = "Azure"
        "4" = "Network Tools"
        "5" = "Search Tools"
        #>
        "6" = "CIS-CAT Clone"
        "7" = "Quit"
    }

    $selectedOption = $null

    while ($null -eq $selectedOption) {
        Write-Host "Select one of the following menus:"
        foreach ($key in $menuDescriptions.Keys | Sort-Object) {
            Write-Host "$key. $($menuDescriptions[$key])"
        }

        $selection = Read-Host "Enter your selection"

        if ($menuOptions.ContainsKey($selection)) {
            & $menuOptions[$selection]
            $selectedOption = $selection
        } else {
            Write-Host "Invalid selection"
        }
    }
}