# install-software.ps1
# Interaktive Software-Auswahl mit winget, erst abfragen, dann installieren
# Als Administrator ausführen!

function Abfrage {
    param (
        [string]$Name,
        [string]$Id,
        [int]$Index,
        [int]$Total
    )

    $antwort = Read-Host "[$Index/$Total] Möchtest du '$Name' installieren? (j/n)"
    if ($antwort -eq 'j') {
        return @{ Name = $Name; Id = $Id }
    } else {
        return $null
    }
}

# Kategorien mit Programmen und Winget-IDs
$softwareListe = [ordered]@{
    "1 / 10: System & Tools" = @(
        @{ Name = "PowerShell (7)"; Id = "Microsoft.PowerShell" },
        @{ Name = "PowerToys"; Id = "Microsoft.PowerToys" },
        @{ Name = "7-Zip"; Id = "7zip.7zip" },
        @{ Name = "PuTTY"; Id = "PuTTY.PuTTY" },
        @{ Name = "WinSCP"; Id = "WinSCP.WinSCP" },
        @{ Name = "PSPad Editor"; Id = "JanFiala.PSPad.x64" },
        @{ Name = "Notepad++"; Id = "Notepad++.Notepad++" },
        @{ Name = "Git"; Id = "Git.Git" }
    )

    "2 / 10: Hardware & Treiber" = @(
        @{ Name = "AMD Chipset Drivers"; Id = "AMD.AMDChipsetSoftware" },
        @{ Name = "AMD Radeon Software"; Id = "AMD.RadeonSoftware" },
        @{ Name = "Intel Chipset Device Software"; Id = "Intel.IntelChipsetDeviceSoftware" },
        @{ Name = "Intel Graphics Driver"; Id = "Intel.GraphicsCommandCenter" },
        @{ Name = "NVIDIA Display Driver"; Id = "NVIDIA.NVidiaDisplayDriver" },
        @{ Name = "NVIDIA PhysX"; Id = "NVIDIA.NvidiaPhysX" },
        @{ Name = "Realtek High Definition Audio Driver"; Id = "Realtek.RealtekHighDefinitionAudio" },
        @{ Name = "Synaptics Touchpad Driver"; Id = "Synaptics.SynapticsPointingDeviceDriver" }
    )

    "3 / 10: Security" = @(
        @{ Name = "Windows Defender Antivirus"; Id = "Microsoft.WindowsDefender" },
        @{ Name = "Malwarebytes"; Id = "Malwarebytes.Malwarebytes" },
        @{ Name = "Bitdefender Antivirus Free"; Id = "Bitdefender.BitdefenderFree" },
        @{ Name = "Avast Free Antivirus"; Id = "Avast.Avast" },
        @{ Name = "Kaspersky Internet Security"; Id = "Kaspersky.KasperskyInternetSecurity" },
        @{ Name = "Norton Security"; Id = "Norton.NortonSecurity" },
        @{ Name = "ESET NOD32 Antivirus"; Id = "ESET.ESETNOD32Antivirus" },
        @{ Name = "Sophos Home"; Id = "Sophos.SophosHome" },
        @{ Name = "McAfee"; Id = "McAfee.McAfee" },
        @{ Name = "1Password"; Id = "1Password.1Password" },
        @{ Name = "Bitwarden"; Id = "Bitwarden.Bitwarden" },
        @{ Name = "LastPass"; Id = "LastPass.LastPass" }
    )

    "4 / 10: Browser" = @(
        @{ Name = "Google Chrome"; Id = "Google.Chrome" },
        @{ Name = "Mozilla Firefox"; Id = "Mozilla.Firefox" },
        @{ Name = "Microsoft Edge"; Id = "Microsoft.Edge" },
        @{ Name = "Opera GX"; Id = "Opera.OperaGX" }
    )

    "5 / 10: Cloud & Backup" = @(
        @{ Name = "Microsoft OneDrive"; Id = "Microsoft.OneDrive" },
        @{ Name = "Dropbox"; Id = "Dropbox.Dropbox" },
        @{ Name = "Google Drive"; Id = "Google.Drive" }
    )

    "6 / 10: Kommunikation" = @(
        @{ Name = "Microsoft Teams"; Id = "Microsoft.Teams" },
        @{ Name = "Discord"; Id = "Discord.Discord" },
        @{ Name = "TeamSpeak Client"; Id = "TeamSpeakSystems.TeamSpeakClient" },
        @{ Name = "Zoom"; Id = "Zoom.Zoom" },
        @{ Name = "TeamViewer"; Id = "TeamViewer.TeamViewer" }
    )

    "7 / 10: Office & PDF" = @(
        @{ Name = "Microsoft Office"; Id = "Microsoft.Office" },
        @{ Name = "LibreOffice"; Id = "TheDocumentFoundation.LibreOffice" },
        @{ Name = "Adobe Acrobat Reader"; Id = "Adobe.Acrobat.Reader.64-bit" },
        @{ Name = "OnlyOffice Desktop Editors"; Id = "ONLYOFFICE.DesktopEditors" },
        @{ Name = "Microsoft Loop"; Id = "Microsoft.Loop" }
    )
    
    "8 / 10: Entwicklung" = @(
        @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode" },
        @{ Name = "Docker Desktop"; Id = "Docker.DockerDesktop" },
        @{ Name = "Python 3"; Id = "Python.Python.3" },
        @{ Name = "Node.js LTS"; Id = "OpenJS.NodeJS.LTS" }
    )

    "9 / 10: Medien & Bild" = @(
        @{ Name = "VLC Media Player"; Id = "VideoLAN.VLC" },
        @{ Name = "Spotify"; Id = "Spotify.Spotify" },
        @{ Name = "GIMP (Bildbearbeitung)"; Id = "GIMP.GIMP" },
        @{ Name = "IrfanView"; Id = "IrfanSkiljan.IrfanView" }
    )

    "10 / 10: Spiele & Launcher" = @(
        @{ Name = "Steam"; Id = "Valve.Steam" },
        @{ Name = "EA Desktop"; Id = "ElectronicArts.EADesktop" },
        @{ Name = "Epic Games Launcher"; Id = "EpicGames.EpicGamesLauncher" },
        @{ Name = "Ubisoft Connect"; Id = "Ubisoft.Connect" },
        @{ Name = "GOG Galaxy"; Id = "GOG.Galaxy" },
        @{ Name = "Battle.net"; Id = "Blizzard.BattleNet" },
        @{ Name = "Riot Client"; Id = "RiotGames.RiotClient" },
        @{ Name = "Minecraft Launcher"; Id = "Microsoft.MinecraftLauncher" }
    )
}

$installListe = @()

# Alle Programme zählen für die Anzeige
$alleProgramme = $softwareListe.Values | ForEach-Object { $_ } | Measure-Object | Select-Object -ExpandProperty Count
$gesamtAnzahl = $alleProgramme

$counter = 1

Write-Host "`n### Schritt 1: Auswahl der Programme ###`n" -ForegroundColor Cyan

foreach ($kategorie in $softwareListe.Keys) {
    Write-Host "`n--- $kategorie ---" -ForegroundColor Yellow
    foreach ($programm in $softwareListe[$kategorie]) {
        $wahl = Abfrage -Name $programm.Name -Id $programm.Id -Index $counter -Total $gesamtAnzahl
        if ($wahl) {
            $installListe += $wahl
        }
        $counter++
    }
}

if ($installListe.Count -eq 0) {
    Write-Host "`nKeine Programme zum Installieren ausgewählt." -ForegroundColor Yellow
    pause
    exit
}

Write-Host "`n### Schritt 2: Installation startet ###`n" -ForegroundColor Green

foreach ($programm in $installListe) {
    Write-Host "`nInstalliere $($programm.Name)..." -ForegroundColor Cyan
    winget install --id $programm.Id --accept-package-agreements --accept-source-agreements -h
}

Write-Host "`nAlle ausgewählten Programme wurden installiert." -ForegroundColor Green
pause
