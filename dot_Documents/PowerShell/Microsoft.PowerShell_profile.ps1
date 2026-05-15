Invoke-Expression (& { (zoxide init powershell --cmd cd | Out-String) })

# Warn when C:\ is >= 95% full
$_drive = Get-PSDrive -Name C -ErrorAction SilentlyContinue
if ($_drive) {
    $_total = $_drive.Used + $_drive.Free
    if ($_total -gt 0) {
        $_pct = [math]::Round(100 * $_drive.Used / $_total, 1)
        if ($_pct -ge 95) {
            Write-Warning "C:\ disk is ${_pct}% full — run cleanmgr or free space."
        }
    }
}
Remove-Variable _drive, _total, _pct -ErrorAction SilentlyContinue

# WSL distro shortcuts
function fd { wsl -d Fedora @args }
function ol { wsl -d OracleLinux @args }
function db { wsl -d Debian @args }
