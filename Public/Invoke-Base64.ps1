
<#
.SYNOPSIS
    This function allows the user to encode or decode a string or file using the base64 encoding/decoding algorithm. The user must provide the input string or file as the $inputVar parameter and specify whether the input is a string or file using the $inputType parameter. The user must also specify the desired output type using the $outputType parameter. If the $inputType is 'string', the function will encode or decode the input string using the [Convert]::ToBase64String and [System.Text.Encoding]::Unicode.GetString methods, respectively. If the $inputType is 'file', the function will read the contents of the specified file and encode or decode them using the same methods.
#>function Invoke-Base64 {
    param(
        $inputVar,
        $inputType,
        $outputType
    )

    # Check if input is a string or a file
    if ($inputType -eq "string") {
        # Check if the user wants to encode or decode the input string
        if ($outputType -eq "encode") {
            $output = [Convert]::ToBase64String([Text.Encoding]::Unicode.GetBytes($inputVar))
            Write-Output "Encoded string: $output"
        }
        elseif ($outputType -eq "decode") {
            $output = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($inputVar))
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

    #if (-not $inputVar -or -not $inputType) {
        Write-Output "`n`n"
        Show-Menu
    #}
}