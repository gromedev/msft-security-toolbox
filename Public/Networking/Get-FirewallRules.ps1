Function Get-FirewallRules {
    # Fetch all firewall rules
    $firewallRules = Get-NetFirewallRule

    # Display the rules
    foreach ($rule in $firewallRules) {
        Write-Output "Name: $($rule.Name)"
        Write-Output "DisplayName: $($rule.DisplayName)"
        Write-Output "Description: $($rule.Description)"
        Write-Output "Action: $($rule.Action)"
        Write-Output "Direction: $($rule.Direction)"
        Write-Output "Enabled: $($rule.Enabled)"
        Write-Output "Profile: $($rule.Profile)"
        Write-Output "Grouping: $($rule.Grouping)"
        Write-Output "InterfaceType: $($rule.InterfaceType)"
        Write-Output "----------------------------------------"
    }
}