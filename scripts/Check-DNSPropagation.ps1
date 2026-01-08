# DNS Propagation Checker for e8guide.com
# Checks authoritative nameservers first, then public DNS servers

$domain = "e8guide.com"
$checkInterval = 300  # 5 minutes in seconds

$authoritativeServers = @(
    @{ Name = "ns1.crazydomains.com"; IP = "27.124.125.7" }
    @{ Name = "ns2.crazydomains.com"; IP = $null }  # Will resolve IP
)

$publicDNSServers = @(
    @{ Name = "Cloudflare"; IP = "1.1.1.1" }
    @{ Name = "Google DNS 1"; IP = "8.8.8.8" }
    @{ Name = "Google DNS 2"; IP = "8.8.4.4" }
)

function Write-Status {
    param([string]$Message, [string]$Status, [string]$Color = "White")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "[$timestamp] " -NoNewline -ForegroundColor Gray
    Write-Host "$Message " -NoNewline
    Write-Host $Status -ForegroundColor $Color
}

function Test-DNSServer {
    param([string]$ServerName, [string]$ServerIP, [string]$Domain)
    
    try {
        $result = Resolve-DnsName -Name $Domain -Type A -Server $ServerIP -ErrorAction Stop
        $ips = ($result | Where-Object { $_.Type -eq "A" }).IPAddress -join ", "
        return @{ Success = $true; IPs = $ips; Error = $null }
    }
    catch {
        return @{ Success = $false; IPs = $null; Error = $_.Exception.Message }
    }
}

function Get-ServerIP {
    param([string]$ServerName)
    try {
        $result = Resolve-DnsName -Name $ServerName -Type A -ErrorAction Stop
        return ($result | Where-Object { $_.Type -eq "A" } | Select-Object -First 1).IPAddress
    }
    catch {
        return $null
    }
}

# Resolve ns2.crazydomains.com IP
Write-Host "`n=====================================" -ForegroundColor Cyan
Write-Host "  DNS Propagation Checker" -ForegroundColor Cyan
Write-Host "  Domain: $domain" -ForegroundColor Cyan
Write-Host "  Interval: $($checkInterval/60) minutes" -ForegroundColor Cyan
Write-Host "=====================================`n" -ForegroundColor Cyan

Write-Host "Resolving nameserver IPs..." -ForegroundColor Yellow
$ns2IP = Get-ServerIP -ServerName "ns2.crazydomains.com"
if ($ns2IP) {
    $authoritativeServers[1].IP = $ns2IP
    Write-Host "  ns2.crazydomains.com -> $ns2IP" -ForegroundColor Green
} else {
    Write-Host "  ns2.crazydomains.com -> Could not resolve" -ForegroundColor Red
}
Write-Host ""

$iteration = 1

while ($true) {
    Write-Host "========== Check #$iteration ==========" -ForegroundColor Cyan
    
    # Flush DNS cache
    Write-Host "Flushing DNS cache..." -ForegroundColor Yellow
    Clear-DnsClientCache
    Write-Status "DNS Cache" "Flushed" "Green"
    Write-Host ""
    
    # Check authoritative nameservers
    Write-Host "Authoritative Nameservers:" -ForegroundColor Yellow
    $authoritativeSuccess = $false
    
    foreach ($server in $authoritativeServers) {
        if ($null -eq $server.IP) { continue }
        
        $result = Test-DNSServer -ServerName $server.Name -ServerIP $server.IP -Domain $domain
        
        if ($result.Success) {
            Write-Status "  $($server.Name) ($($server.IP))" "OK - $($result.IPs)" "Green"
            $authoritativeSuccess = $true
        } else {
            $errorShort = $result.Error -replace ".*: ", ""
            Write-Status "  $($server.Name) ($($server.IP))" "FAILED - $errorShort" "Red"
        }
    }
    
    Write-Host ""
    
    # Check public DNS servers if authoritative succeeded
    if ($authoritativeSuccess) {
        Write-Host "Public DNS Servers (Propagation Check):" -ForegroundColor Yellow
        
        foreach ($server in $publicDNSServers) {
            $result = Test-DNSServer -ServerName $server.Name -ServerIP $server.IP -Domain $domain
            
            if ($result.Success) {
                Write-Status "  $($server.Name) ($($server.IP))" "PROPAGATED - $($result.IPs)" "Green"
            } else {
                Write-Status "  $($server.Name) ($($server.IP))" "Not yet propagated" "Yellow"
            }
        }
        
        # Check if all public DNS servers have propagated
        $allPropagated = $true
        foreach ($server in $publicDNSServers) {
            $result = Test-DNSServer -ServerName $server.Name -ServerIP $server.IP -Domain $domain
            if (-not $result.Success) {
                $allPropagated = $false
                break
            }
        }
        
        if ($allPropagated) {
            Write-Host "`n" -NoNewline
            Write-Host "============================================" -ForegroundColor Green
            Write-Host "  DNS FULLY PROPAGATED!" -ForegroundColor Green
            Write-Host "  $domain is now resolving globally" -ForegroundColor Green
            Write-Host "============================================" -ForegroundColor Green
            Write-Host "`nYou can now:" -ForegroundColor Cyan
            Write-Host "  1. Go to GitHub repo Settings -> Pages" -ForegroundColor White
            Write-Host "  2. Verify custom domain shows $domain" -ForegroundColor White
            Write-Host "  3. Enable 'Enforce HTTPS'" -ForegroundColor White
            Write-Host "`nPress any key to exit or wait for script to continue monitoring..."
            break
        }
    } else {
        Write-Host "Public DNS Servers:" -ForegroundColor Yellow
        Write-Host "  Skipped - waiting for authoritative nameservers first" -ForegroundColor Gray
    }
    
    Write-Host ""
    Write-Host "Next check in $($checkInterval/60) minutes... (Press any key to check now, Ctrl+C to stop)" -ForegroundColor Gray
    Write-Host ""
    
    $iteration++
    
    # Wait for keypress or timeout
    $elapsed = 0
    while ($elapsed -lt $checkInterval) {
        if ([Console]::KeyAvailable) {
            $null = [Console]::ReadKey($true)
            Write-Host "Manual check requested...`n" -ForegroundColor Yellow
            break
        }
        Start-Sleep -Milliseconds 500
        $elapsed += 0.5
    }
}
