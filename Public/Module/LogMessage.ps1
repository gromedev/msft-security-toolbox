function LogMessage([string]$message, [string]$color = "White")
{
    $message = "$([DateTime]::Now) - $message"
    Write-Host $message -ForegroundColor $color
}

<#
# Example usage:
LogMessage "This is white text."
LogMessage "This is red text." "Red"
LogMessage "This is green text." "Green"

#>