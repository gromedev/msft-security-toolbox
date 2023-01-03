function Invoke-Base64 {
    param(
    $input,
    $inputType,
    $outputType
    )

# Check if input is a string or a file
if ($inputType -eq "string") {
    # Check if the user wants to encode or decode the input string
    if ($outputType -eq "encode") {
        $output = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($input))
        Write-Output "Encoded string: $output"
    }
    elseif ($outputType -eq "decode") {
        $output = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($input))
        Write-Output "Decoded string: $output"
    }
}
elseif ($inputType -eq "file") {
    # Prompt the user for the file path
    $filePath = Read-Host "Enter the path to the file"

    # Check if the user wants to encode or decode the input file
    if ($outputType -eq "encode") {
        # Read the file contents and encode them
        $fileContents = Get-Content -Path $filePath
        $output = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($fileContents))
        Write-Output "Encoded file contents: $output"
    }
    elseif ($outputType -eq "decode") {
        # Read the file contents and decode them
        $fileContents = Get-Content -Path $filePath
        $output = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($fileContents))
        Write-Output "Decoded file contents: $output"
    }
}

# Return to the menu
Invoke-Menu
}