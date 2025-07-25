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
