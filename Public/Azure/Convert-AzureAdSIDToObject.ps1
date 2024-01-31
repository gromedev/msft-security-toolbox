function ConvertToObjectId {
    $sid = $ObjectId -replace 'S-1-12-1-', '' -replace '-', ' '
    $array = [UInt32[]] $sid.Split()
    $bytes = New-Object 'Byte[]' 16
    [Buffer]::BlockCopy($array, 0, $bytes, 0, 16)
    $objectId = [Guid]::NewGuid($bytes).ToString()

    return $objectId
}