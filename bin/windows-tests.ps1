Write-Output "starting tests";
While ($true) {
   # TEST 3.1
    Write-Output "TEST 3.1 Windows to Windows DNS";
    $IIS_IP = nslookup iis.default.svc.cluster.local | Select-String -Pattern 'Address:'
    if ($IIS_IP[1] -eq $NULL){$RESULT="FAIL"} else {$RESULT="SUCCESS"} 
    @{test=@{id="3.1";name="Windows to Windows DNS";result="$RESULT"}} |  ConvertTo-JSON

   # TEST 3.2
    Write-Output "TEST 3.2 Windows to Windows VIP and Overlay";
    Try{
     $IIS_HTTP = Invoke-WebRequest -Uri "iis.default.svc.cluster.local" -DisableKeepAlive -UseBasicParsing
    }
    Catch{
     $IIS_HTTP = "$_"
    }
    if ($IIS_HTTP.StatusCode -ne 200){$RESULT="FAIL"} else {$RESULT="SUCCESS"} 
    @{test=@{id="3.2";name="Windows to Windows VIP and Overlay";result="$RESULT"}} |  ConvertTo-JSON

   # TEST 4.1
    Write-Output "TEST 4.1 Windows to Linux DNS";
    $NGINX_IP = nslookup nginx.default.svc.cluster.local | Select-String -Pattern 'Address:'
    if ($NGINX_IP[1] -eq $NULL){$RESULT="FAIL"} else {$RESULT="SUCCESS"} 
    @{test=@{id="4.1";name="Windows to Linux DNS";result="$RESULT"}} |  ConvertTo-JSON

   # TEST 4.2
    Write-Output "TEST 4.2 Windows to Linux VIP and Overlay";
    Try{
     $NGINX_HTTP = Invoke-WebRequest -Uri "nginx.default.svc.cluster.local" -DisableKeepAlive -UseBasicParsing
    }
    Catch{
     $NGINX_HTTP = "$_"
    }
    if ($NGINX_HTTP.StatusCode -ne 200){$RESULT="FAIL"} else {$RESULT="SUCCESS"} 
    @{test=@{id="4.2";name="Windows to Windows VIP and Overlay";result="$RESULT"}} |  ConvertTo-JSON

Start-Sleep -Seconds 30 };

