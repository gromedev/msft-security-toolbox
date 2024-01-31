<#
.SYNOPSIS
    This function allows the user to download a video from a specified URL and save it to a specified path with a specified name. If the URL, path, or name are not provided as parameters, the user will be prompted to enter them.
    
.EXAMPLE
    $path = "c:\temp"
    Save-Video 'https://www.example.com'  $path'ripped-video'
    Get-ChildItem c:\temp -Recurse | Where-Object {$_.Extension -eq ".m3u8"} | Rename-Item -NewName {"$($_.BaseName).mp4"}
    #>
function Save-Video {
    Param ($URLIn,$p,$NameIn)

    # Check if yt-dlp is installed
    $ytDlpPath = Read-Host "Enter the path to yt-dlp.exe (e.g. C:\yt-dlp.exe):"
    if (!(Test-Path $ytDlpPath)) {
        # yt-dlp is not installed, prompt the user to install it
        $installUrl = "https://github.com/yt-dlp/yt-dlp"
        Write-Host "yt-dlp is not found at the specified path. Do you want to download it now? (Y/N)"
        $answer = Read-Host
        if ($answer -eq "Y") {
            Start-Process $installUrl
        } else {
            Write-Host "yt-dlp is required to download videos. Please install it and try again."
            return
        }
    }

    # Prompt the user for the path to save the video
    $savePath = Read-Host "Enter the path to save the video:"

    # Prompt the user for the file extension
    $extension = Read-Host "Enter the file extension (e.g. mp4, mkv, etc.): "

    # Set up the arguments for yt-dlp
    $args = "-i --download-archive phchannel.txt -f best -o '$savePath\%(title)s.$extension'"

    If(!(Test-Path $p\$URLIn)){

        New-Item -ItemType Directory -Force -Path $p\$NameIn
    }

    # Start the yt-dlp process
    Start-Process $ytDlpPath -ArgumentList $URLIn, $args -WorkingDirectory $p\$NameIn
    Write-Host "Downloading " $NameIn "Channel"
    Start-Sleep -Seconds 720 ## wait a few minutes to avoid throttling
}
