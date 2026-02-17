Add-Type -AssemblyName System.Windows.Forms

$screens = [System.Windows.Forms.Screen]::AllScreens
$primary = [System.Windows.Forms.Screen]::PrimaryScreen

$secondaryOnLeft = $false
foreach ($s in $screens) {
    if (-not $s.Primary -and $s.Bounds.X -lt $primary.Bounds.X) {
        $secondaryOnLeft = $true
        break
    }
}

if ($secondaryOnLeft) {
    $x = $primary.Bounds.X
} else {
    $x = $primary.Bounds.X + [math]::Floor($primary.Bounds.Width / 2)
}

Start-Process zed -ArgumentList "--new"
