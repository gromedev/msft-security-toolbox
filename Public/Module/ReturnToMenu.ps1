Function ReturnToMenu {
    $ReturnMenu = Read-Host "Return to main menu? (Y/N)"
    if ($ReturnMenu -eq "Y") {
        Show-Menu
    }
    else {
        exit
    }
}