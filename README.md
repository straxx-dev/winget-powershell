# install-software.ps1

**Interaktives PowerShell-Skript zur Installation von Software via winget**

Dieses Skript ermöglicht es, ausgewählte Programme interaktiv per `winget` auf Windows-Systemen zu installieren. Vor der Installation wird der Nutzer gefragt, welche Software er installieren möchte. Die Programme sind in Kategorien organisiert und werden nacheinander abgefragt.

## Features

- Interaktive Abfrage der zu installierenden Programme
- Übersichtliche Kategorisierung nach Systemtools, Treibern, Browsern, Kommunikation uvm.
- Automatisierte Installation per winget mit Akzeptieren von Lizenz- und Quellvereinbarungen
- Übersichtliche Fortschrittsanzeige mit Nummerierung der Abfragen

## Voraussetzungen

- Windows 10 oder höher
- PowerShell mit Administratorrechten (Skript muss als Admin ausgeführt werden)
- Microsoft `winget` (Windows Package Manager) installiert und konfiguriert

## Nutzung

1. Skript herunterladen oder aus dem Repository klonen.
2. PowerShell als Administrator öffnen.
3. In das Verzeichnis wechseln, wo sich das Skript befindet.
4. Skript mit folgendem Befehl ausführen:
   ```powershell
   .\install-software.ps1

## Enthaltene Software
1 / 10: System & Tools
- PowerShell (7)
- PowerToys
- 7-Zip
- PuTTY
- WinSCP
- PSPad Editor
- Notepad++
- Git

2 / 10: Hardware & Treiber
- AMD Chipset Drivers
- AMD Radeon Software
- Intel Chipset Device Software
- Intel Graphics Driver
- NVIDIA Display Driver
- NVIDIA PhysX
- Realtek High Definition Audio Driver
- Synaptics Touchpad Driver

3 / 10: Security
- Windows Defender Antivirus
- Malwarebytes
- Bitdefender Antivirus Free
- Avast Free Antivirus
- Kaspersky Internet Security
- Norton Security
- ESET NOD32 Antivirus
- Sophos Home
- McAfee
- 1Password
- Bitwarden
- LastPass

4 / 10: Browser
- Google Chrome
- Mozilla Firefox
- Microsoft Edge
- Opera GX

5 / 10: Cloud & Backup
- Microsoft OneDrive
- Dropbox
- Google Drive

6 / 10: Kommunikation
- Microsoft Teams
- Discord
- TeamSpeak Client
- Zoom
- TeamViewer

7 / 10: Office & PDF
- Microsoft Office
- LibreOffice
- Adobe Acrobat Reader
- OnlyOffice Desktop Editors
- Microsoft Loop

8 / 10: Entwicklung
- Visual Studio Code
- Docker Desktop
- Python 3
- Node.js LTS

9 / 10: Medien & Bild
- VLC Media Player
- Spotify
- GIMP (Bildbearbeitung)
- IrfanView

10 / 10: Spiele & Launcher
- Steam
- EA Desktop
- Epic Games Launcher
- Ubisoft Connect
- GOG Galaxy
- Battle.net
- Riot Client
- Minecraft Launcher
