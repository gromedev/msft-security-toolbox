function Set-FileNamesByDate() {
    $month = 1..12
    foreach ($SingleMonth in $Month) {
        $Name = "2022-{0:d2}" -f $SingleMonth 
        new-Item -ItemType Directory -Name $Name -Path $env:temp
    }
}