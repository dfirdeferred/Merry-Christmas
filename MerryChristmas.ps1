
#=======================================
# Merry Christasmas From DFIRdeferred  
#=======================================



[CmdletBinding()]
param(
    [switch]$ShowSantasIntel
)



# Make a List
$SantasList = [System.Collections.Generic.List[object]]::new()

$niceKids    = @()
$naughtyKids = @()

$SantasList.Add("Left cookies and milk for Santa")
$SantasList.Add("Threw a bedtime tantrum")
$SantasList.Add("Shared toys with friends")
$SantasList.Add("Hacked and broke the family firewall while testing custom proxies ")
$SantasList.Add("Did homework without being asked")
$SantasList.Add("Fed the reindeer in the backyard")
$SantasList.Add("Pulled little sister's hair")


# Check List Twice 
for ($pass = 1; $pass -le 2; $pass++) {
    $index = 0
    foreach ($behavior in $SantasList) {
        $lower = $behavior.ToLower()

# Default Assumption: All Kids Are Naughty! Muuuuaaahahahaha! J/k
        $status = "Naughty"
        $notes  = "Behavior did not meet Nice criteria"
        $kidDeservesPresent = $false

        if ($lower -match "cookie|milk|share|homework|reindeer") {
            $status = "Nice"
            $notes  = "Good behavior detected"
        }
        elseif ($lower -match "firewall") {
            $status = "Naughty"
            $notes  = "Firewall exception (E.L.F.Red Team warning, but approved)"
            $kidDeservesPresent = $true
        }

        $kid = [pscustomobject]@{
            Name     = "Kid_$pass`_$index"
            Behavior = $behavior
            Status   = $status
            Notes    = $notes
        }

        if ($status -eq "Nice") {
            $niceKids    += $kid
        }
        else {
            $naughtyKids += $kid
        }

        $index++
    }
}


# Find Out Who Is Naughty or Nice
$SantasPresents = @()

# Nice kids always receive gifts
foreach ($kid in $niceKids) {
    $SantasPresents += "Awesome Present!"
}

# TODO: report this to Santa's IRT team later! 
foreach ($kid in $naughtyKids) {
    if ($kid.Notes -match "Firewall exception") {
            $SantasPresents += "Awesome Present! (Firewall Exception. Get this kid a Flipper!)"
    }
}


# Optional  Santa's Intel
if ($ShowSantasIntel) {
    Write-Host "`n=== Santa's Nice List ===" -ForegroundColor Green
    $niceKids | Format-Table Name, Behavior, Status -AutoSize

    Write-Host "`n=== Santa's Naughty List ===" -ForegroundColor Red
    $naughtyKids | Format-Table Name, Behavior, Status -AutoSize
}



#####################################################
#                                                   #
#            MAIN                                   #
#####################################################


# Santa's Super Secret Payload.. (Surprise ASCII Art Reveal)
if ($SantasPresents.Count -gt 0) {

# TODO: rotate secrets every Christmas Eve 🎅
    $base64 = @"
ICAgICAgICAgICAgICAgICAgICAgKiAgICAgICoKICAgICAgICAgKiAgICAgIC4gICAgICAgICogICAgICAgIC4KICAgICAgIC4gICAgLiAgICAgICAgKiAg
ICAgICAgLgogICAgICAgICAgICAgICAgICAgICAgIC4gICAgICAgICoKICAgICAgICAgICAgICAgICAuICAgICAgICAgICAgICAgKgogICAgICAgICAgICAg
ICAgICAgICAgICAgIC4gICAgICAgIC4KICAgICAgICAgICAgICAgICAgXy4uLl8gICAgICAgICAqCiAgICAgKiAgICAgICAgIC4tJ18uLi5fJycuICAgICAg
ICAgICAqCiAgICAgICAgICAgICAgLicgLicgICAgICAnLlwgICAqCiAgICogICAgICAgICAvIC4nICAgICAgICAgJy4nLgogICAgICAgICAgICAuICcgICAg
ICAgICAgICAgICB8CiAgICAgICAqICAgIHwgfCAgIFMgQSBOIFQgQSAgIHwgICAgICAgICoKICAgICAgICAgICAgfCB8ICAgIEkgUyAgICAgICB8CiAgICAg
ICAgICAgIC4gJyAgIEMgTyBNIEkgTiBHIHwKICAgICAgICAgICAgIFwgJy4gICBUIE8gICAgICAvCiAgICAgICAqICAgICAnLiBgLiAgIFQgTyBXIE4hJwog
ICAgICAgICAgICAgIC4nX18uX19fLiAgICoKICAgICAqICAgICAgKF9fX198X19fXykgICAgICAgKgogICAgICAgICAgICAgLyAgICB8ICAgIFwgICoKICAg
ICogICAgICAgLyAgKiAgfCAgKiAgICAgICAgICAgICAqICAgICAgfCAgICAgICoKICAgICB+fn4gc2xlaWdoIGJlbGxzIHJpbmdpbmcgfn5+
"@

    $decoded = [System.Text.Encoding]::UTF8.GetString(
        [Convert]::FromBase64String($base64)
    )

    Write-Host ""
    Write-Host $decoded -ForegroundColor Green
    Write-Host ""

    $notes = @(
    659, 659, 659, 659, 659, 659, 659, 784, 523, 587, 659
    )

    $durations = @(
        300, 300, 600,
        300, 300, 600,
        300, 300, 300, 300, 900
    )

    for ($i = 0; $i -lt $notes.Count; $i++) {
        [Console]::Beep($notes[$i], $durations[$i])
    }
}

