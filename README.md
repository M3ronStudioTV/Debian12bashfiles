# phpMyAdmin Installation Scripts

## Beschreibung

Diese Bash-Skripte automatisieren die Installation und Konfiguration von phpMyAdmin auf Ubuntu/Debian-Systemen. Es stehen zwei Versionen zur Verfügung:

- **phpmyadmin8_2.sh**: Installation mit PHP 8.2
- **phpmyadmin8_3.sh**: Installation mit PHP 8.3 (empfohlen)

Beide Skripte installieren alle notwendigen Komponenten einschließlich Apache2, PHP, MariaDB und phpMyAdmin.

### PHP 8.3 vs PHP 8.2 - Wichtige Verbesserungen

#### Performance-Verbesserungen
- **Bis zu 30% schnellere Ausführung** bei typischen Web-Anwendungen
- **Verbesserte JIT-Engine** für bessere Performance bei CPU-intensiven Aufgaben
- **Optimierte Speichernutzung** und reduzierte Memory-Footprints

#### Neue Features
- **Typed Class Constants**: Vollständige Typisierung für Klassenkonstanten
- **Dynamic Class Constant Fetch**: Dynamischer Zugriff auf Klassenkonstanten
- **Random Extension**: Neue native Random-API für bessere Performance
- **Improved Type System**: Erweiterte Typisierung und bessere Fehlerbehandlung

#### Sicherheitsverbesserungen
- **Enhanced Security Headers**: Verbesserte HTTP-Sicherheitsheader
- **Better Input Validation**: Erweiterte Eingabevalidierung
- **Improved Error Handling**: Bessere Fehlerbehandlung und Logging

#### Kompatibilität
- **Backward Compatibility**: Vollständige Abwärtskompatibilität mit PHP 8.2
- **Deprecation Warnings**: Klarere Warnungen für veraltete Funktionen
- **Migration Guide**: Einfache Migration von PHP 8.2 zu 8.3

## Funktionen

### Gemeinsame Funktionen (beide Skripte)
- **System-Updates**: Aktualisiert das System und führt Upgrades durch
- **Apache2 Installation**: Installiert und konfiguriert den Apache2 Webserver
- **MariaDB Installation**: Installiert MariaDB Datenbankserver
- **phpMyAdmin Installation**: Lädt die neueste phpMyAdmin-Version herunter und installiert sie
- **Automatische Konfiguration**: Konfiguriert Apache2 für phpMyAdmin-Zugriff
- **Datenbank-Benutzer**: Erstellt automatisch einen Admin-Benutzer mit zufälligem Passwort
- **Sicherheitskonfiguration**: Setzt entsprechende Berechtigungen und Sicherheitseinstellungen

### phpmyadmin8_2.sh (PHP 8.2)
- **PHP 8.2 Installation**: Installiert PHP 8.2 mit allen notwendigen Erweiterungen
- **Grundlegende Konfiguration**: Standard phpMyAdmin-Setup

### phpmyadmin8_3.sh (PHP 8.3) - Empfohlen
- **PHP 8.3 Installation**: Installiert PHP 8.3 mit allen notwendigen Erweiterungen
- **Erweiterte Sicherheit**: Zusätzliche Sicherheitsheader und Konfigurationen
- **MariaDB-Sicherung**: Automatische MariaDB-Sicherheitskonfiguration
- **Konfigurationsspeicher**: Vollständiger phpMyAdmin-Konfigurationsspeicher (pmadb)
- **Erweiterte Features**: Bookmarks, Export-Templates, Designer-Settings und mehr
- **Metro-Design**: Standardmäßig modernes Metro-Design
- **Detaillierte Logs**: Erweiterte Protokollierung und Statusmeldungen

## Voraussetzungen

- Ubuntu/Debian-basiertes System
- Root-Zugriff oder sudo-Berechtigungen
- Internetverbindung für Downloads
- Mindestens 1GB freier Speicherplatz

## Installation

### phpmyadmin8_2.sh (PHP 8.2)

1. **Skript herunterladen**:
   ```bash
   wget https://raw.githubusercontent.com/your-repo/phpmyadmin8_2.sh
   ```

2. **Ausführungsberechtigung erteilen**:
   ```bash
   chmod +x phpmyadmin8_2.sh
   ```

3. **Skript ausführen**:
   ```bash
   ./phpmyadmin8_2.sh
   ```

### phpmyadmin8_3.sh (PHP 8.3) - Empfohlen

1. **Skript herunterladen**:
   ```bash
   wget https://raw.githubusercontent.com/your-repo/phpmyadmin8_3.sh
   ```

2. **Ausführungsberechtigung erteilen**:
   ```bash
   chmod +x phpmyadmin8_3.sh
   ```

3. **Skript ausführen**:
   ```bash
   ./phpmyadmin8_3.sh
   ```

**Hinweis**: Das PHP 8.3 Skript wird empfohlen, da es erweiterte Sicherheitsfeatures und zusätzliche phpMyAdmin-Funktionen bietet.

## Was wird installiert

### Apache2
- Apache2 Webserver
- PHP Module für Apache2 (8.2 oder 8.3)

### PHP Pakete

#### phpmyadmin8_2.sh (PHP 8.2)
- php8.2-cli
- php8.2-common
- php8.2-curl
- php8.2-gd
- php8.2-intl
- php8.2-mbstring
- php8.2-mysql
- php8.2-opcache
- php8.2-readline
- php8.2-xml
- php8.2-xsl
- php8.2-zip
- php8.2-bz2

#### phpmyadmin8_3.sh (PHP 8.3)
- php8.3-cli
- php8.3-common
- php8.3-curl
- php8.3-gd
- php8.3-intl
- php8.3-mbstring
- php8.3-mysql
- php8.3-opcache
- php8.3-readline
- php8.3-xml
- php8.3-xsl
- php8.3-zip
- php8.3-bz2
- php8.3-fileinfo

### MariaDB
- MariaDB Server
- MariaDB Client
- Automatische Sicherheitskonfiguration (nur 8.3)

### phpMyAdmin
- Neueste phpMyAdmin-Version
- Automatische Apache2-Konfiguration
- Sicherheitskonfiguration
- Konfigurationsspeicher (pmadb) - nur 8.3
- Metro-Design - nur 8.3

## Nach der Installation

### Zugangsdaten finden
Nach erfolgreicher Installation werden die Zugangsdaten in der Datei `/home/phpmyadmin-data.txt` gespeichert:

```bash
cat /home/phpmyadmin-data.txt
```

### phpMyAdmin aufrufen
Öffnen Sie Ihren Browser und navigieren Sie zu:
```
http://[IHRE-SERVER-IP]/phpmyadmin
```

### Standard-Zugangsdaten
- **Benutzername**: `admin`
- **Passwort**: Wird automatisch generiert und in `/home/phpmyadmin-data.txt` gespeichert

### Zusätzliche Features (nur phpmyadmin8_3.sh)
- **Konfigurationsspeicher**: Speichert Einstellungen, Bookmarks und Export-Templates
- **Metro-Design**: Modernes Standard-Design
- **Erweiterte Sicherheit**: Zusätzliche HTTP-Sicherheitsheader
- **Detaillierte Logs**: Erweiterte Statusmeldungen und Protokollierung

## Sicherheitshinweise

### Gemeinsame Sicherheitsfeatures
- Das Skript erstellt einen Admin-Benutzer mit allen Berechtigungen
- Das Passwort wird automatisch generiert und ist sicher
- Apache2-Konfiguration schützt sensible phpMyAdmin-Verzeichnisse
- Temporäre Verzeichnisse werden mit korrekten Berechtigungen erstellt

### Zusätzliche Sicherheit (phpmyadmin8_3.sh)
- **MariaDB-Sicherung**: Automatische Konfiguration von MariaDB-Sicherheitseinstellungen
- **HTTP-Sicherheitsheader**: X-Content-Type-Options, X-Frame-Options, X-XSS-Protection
- **Erweiterte Verzeichnisschutz**: Zusätzliche Verzeichnisse werden vor Zugriff geschützt
- **Sichere Cookie-Verschlüsselung**: Automatisch generierter Blowfish-Secret

## Troubleshooting

### Häufige Probleme

1. **Port 80 ist belegt**:
   ```bash
   sudo netstat -tlnp | grep :80
   sudo systemctl stop [service-name]
   ```

2. **PHP-Module nicht geladen**:
   ```bash
   sudo a2enmod php8.2
   sudo systemctl reload apache2
   ```

3. **MariaDB startet nicht**:
   ```bash
   sudo systemctl status mariadb
   sudo systemctl start mariadb
   ```

### Logs überprüfen
```bash
# Apache2 Logs
sudo tail -f /var/log/apache2/error.log

# MariaDB Logs
sudo tail -f /var/log/mysql/error.log

# PHP Logs (je nach Version)
sudo tail -f /var/log/php8.2-fpm.log  # Für PHP 8.2
sudo tail -f /var/log/php8.3-fpm.log  # Für PHP 8.3
```

## Systemanforderungen

- **Betriebssystem**: Ubuntu 18.04+ oder Debian 9+
- **RAM**: Mindestens 512MB (1GB empfohlen)
- **Speicherplatz**: Mindestens 1GB freier Speicher
- **Netzwerk**: Internetverbindung für Downloads

## Lizenz

Dieses Skript steht unter der MIT-Lizenz zur Verfügung.

## Support

Bei Problemen oder Fragen erstellen Sie bitte ein Issue im entsprechenden Repository oder kontaktieren Sie den Entwickler.

## Quellen und weitere Informationen

### PHP-Versionen
- **PHP 8.3 Changelog**: https://www.php.net/ChangeLog-8.php#8.3.0
- **PHP 8.2 Changelog**: https://www.php.net/ChangeLog-8.php#8.2.0
- **PHP Migration Guide**: https://www.php.net/manual/de/migration80.php

### phpMyAdmin
- **Offizielle phpMyAdmin Website**: https://www.phpmyadmin.net/
- **phpMyAdmin Dokumentation**: https://docs.phpmyadmin.net/
- **phpMyAdmin GitHub**: https://github.com/phpmyadmin/phpmyadmin
- **phpMyAdmin Konfigurationsspeicher**: https://docs.phpmyadmin.net/en/latest/setup.html#phpmyadmin-configuration-storage

### Apache2 & MariaDB
- **Apache2 Dokumentation**: https://httpd.apache.org/docs/
- **MariaDB Dokumentation**: https://mariadb.com/kb/en/documentation/
- **MariaDB Sicherheitskonfiguration**: https://mariadb.com/kb/en/mysql_secure_installation/

### Ubuntu/Debian
- **Ubuntu Server Guide**: https://ubuntu.com/server/docs
- **Debian Administrator's Handbook**: https://debian-handbook.info/

## Changelog

### Version 2.0 (phpmyadmin8_3.sh)
- **PHP 8.3 Support**: Neueste PHP-Version mit verbesserter Performance
- **Erweiterte Sicherheit**: HTTP-Sicherheitsheader und MariaDB-Sicherung
- **Konfigurationsspeicher**: Vollständiger phpMyAdmin-Konfigurationsspeicher (pmadb)
- **Metro-Design**: Modernes Standard-Design
- **Erweiterte Features**: Bookmarks, Export-Templates, Designer-Settings
- **Verbesserte Logs**: Detaillierte Statusmeldungen und Protokollierung
- **Sichere Cookie-Verschlüsselung**: Automatisch generierter Blowfish-Secret

### Version 1.0 (phpmyadmin8_2.sh)
- Erste Version des Installationsskripts
- Unterstützung für PHP 8.2
- Automatische Konfiguration von Apache2 und MariaDB
- Sichere Passwort-Generierung
- Automatische Zugangsdaten-Speicherung 
