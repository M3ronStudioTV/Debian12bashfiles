# phpMyAdmin Installation Scripts

## ⚠️ WICHTIGE HINWEISE

### Vor der Installation
- **Vollständige Deinstallation erforderlich**: Wenn Sie bereits eine ältere PHP-Version installiert haben, deinstallieren Sie diese **VOLLSTÄNDIG** vor der Installation einer neuen Version
- **Backup erstellen**: Erstellen Sie ein Backup Ihrer Datenbanken und Konfigurationen
- **PHP 8.4 Beta-Status**: PHP 8.4 ist noch in der Entwicklung und **NICHT GETESTET** - verwenden Sie nur in Testumgebungen

### Deinstallation vorheriger Versionen
```bash
# PHP 8.2/8.3 vollständig entfernen
sudo apt purge php8.2* php8.3* -y
sudo apt autoremove -y
sudo rm -rf /etc/php/8.2 /etc/php/8.3
sudo rm -f /etc/apache2/conf-available/phpmyadmin.conf
sudo rm -rf /usr/share/phpmyadmin
sudo systemctl reload apache2
```

## Beschreibung

Diese Bash-Skripte automatisieren die Installation und Konfiguration von phpMyAdmin auf Ubuntu/Debian-Systemen. Es stehen drei Versionen zur Verfügung:

- **phpmyadmin8_2.sh**: Installation mit PHP 8.2 (stabil)
- **phpmyadmin8_3.sh**: Installation mit PHP 8.3 (empfohlen, stabil)
- **phpmyadmin8_4.sh**: Installation mit PHP 8.4 (experimentell, nicht getestet)

Alle Skripte installieren alle notwendigen Komponenten einschließlich Apache2, PHP, MariaDB und phpMyAdmin.

### PHP Versionen Vergleich - Wichtige Verbesserungen

#### PHP 8.4 vs PHP 8.3 vs PHP 8.2

##### Performance-Verbesserungen
- **PHP 8.4**: Bis zu 40% schnellere Ausführung, neue JIT-Engine, optimierte Speichernutzung
- **PHP 8.3**: Bis zu 30% schnellere Ausführung, verbesserte JIT-Engine
- **PHP 8.2**: Standard Performance, stabile JIT-Engine

##### Neue Features
- **PHP 8.4**: Neue JIT-Engine, erweiterte Typisierung, verbesserte Performance-Optimierungen
- **PHP 8.3**: Typed Class Constants, Dynamic Class Constant Fetch, Random Extension
- **PHP 8.2**: Grundlegende Features, stabile API

##### Sicherheitsverbesserungen
- **PHP 8.4**: Erweiterte Sicherheitsheader, Permissions-Policy, Referrer-Policy
- **PHP 8.3**: Enhanced Security Headers, Better Input Validation
- **PHP 8.2**: Standard Sicherheitsfeatures

##### Kompatibilität
- **PHP 8.4**: Experimentell, nicht vollständig getestet
- **PHP 8.3**: Vollständige Abwärtskompatibilität mit PHP 8.2
- **PHP 8.2**: Stabil, bewährt

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

### phpmyadmin8_4.sh (PHP 8.4) - Experimentell
- **PHP 8.4 Installation**: Installiert PHP 8.4 mit allen notwendigen Erweiterungen
- **Erweiterte Sicherheit**: Neue Sicherheitsheader (Permissions-Policy, Referrer-Policy)
- **Performance-Optimierungen**: MPM Event Module, Gzip-Kompression, Browser-Caching
- **Konfigurationsspeicher**: Vollständiger phpMyAdmin-Konfigurationsspeicher (pmadb)
- **Erweiterte Features**: Alle Features von 8.3 plus PHP 8.4-spezifische Optimierungen
- **Metro-Design**: Standardmäßig modernes Metro-Design
- **Detaillierte Logs**: Emoji-basierte Statusmeldungen und erweiterte Protokollierung
- **Apache2-Optimierungen**: Thread-basierte Konfiguration für bessere Performance

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

### phpmyadmin8_4.sh (PHP 8.4) - Experimentell

1. **Skript herunterladen**:
   ```bash
   wget https://raw.githubusercontent.com/your-repo/phpmyadmin8_4.sh
   ```

2. **Ausführungsberechtigung erteilen**:
   ```bash
   chmod +x phpmyadmin8_4.sh
   ```

3. **Skript ausführen**:
   ```bash
   ./phpmyadmin8_4.sh
   ```

**Hinweis**: Das PHP 8.3 Skript wird für Produktionsumgebungen empfohlen. PHP 8.4 ist experimentell und sollte nur in Testumgebungen verwendet werden.

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

#### phpmyadmin8_4.sh (PHP 8.4)
- php8.4-cli
- php8.4-common
- php8.4-curl
- php8.4-gd
- php8.4-intl
- php8.4-mbstring
- php8.4-mysql
- php8.4-opcache
- php8.4-readline
- php8.4-xml
- php8.4-xsl
- php8.4-zip
- php8.4-bz2
- php8.4-fileinfo
- php8.4-json

### MariaDB
- MariaDB Server
- MariaDB Client
- Automatische Sicherheitskonfiguration (nur 8.3)

### phpMyAdmin
- Neueste phpMyAdmin-Version
- Automatische Apache2-Konfiguration
- Sicherheitskonfiguration
- Konfigurationsspeicher (pmadb) - nur 8.3/8.4
- Metro-Design - nur 8.3/8.4
- Performance-Optimierungen - nur 8.4

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

### Zusätzliche Features (nur phpmyadmin8_4.sh)
- **Konfigurationsspeicher**: Speichert Einstellungen, Bookmarks und Export-Templates
- **Metro-Design**: Modernes Standard-Design
- **Erweiterte Sicherheit**: Neue Sicherheitsheader (Permissions-Policy, Referrer-Policy)
- **Performance-Optimierungen**: MPM Event Module, Gzip-Kompression, Browser-Caching
- **Detaillierte Logs**: Emoji-basierte Statusmeldungen und erweiterte Protokollierung
- **Apache2-Optimierungen**: Thread-basierte Konfiguration für bessere Performance

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

### Zusätzliche Sicherheit (phpmyadmin8_4.sh)
- **MariaDB-Sicherung**: Automatische Konfiguration von MariaDB-Sicherheitseinstellungen
- **HTTP-Sicherheitsheader**: X-Content-Type-Options, X-Frame-Options, X-XSS-Protection, Referrer-Policy, Permissions-Policy
- **Erweiterte Verzeichnisschutz**: Zusätzliche Verzeichnisse werden vor Zugriff geschützt
- **Sichere Cookie-Verschlüsselung**: Automatisch generierter Blowfish-Secret
- **Performance-Sicherheit**: Thread-basierte Apache2-Konfiguration für bessere Sicherheit

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
sudo tail -f /var/log/php8.4-fpm.log  # Für PHP 8.4
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
- **PHP Performance Benchmarks**: https://www.php.net/ChangeLog-8.php#8.3.0

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

### Version 3.0 (phpmyadmin8_4.sh) - Experimentell
- **PHP 8.4 Support**: Neueste PHP-Version mit experimenteller JIT-Engine
- **Erweiterte Sicherheit**: Neue Sicherheitsheader (Permissions-Policy, Referrer-Policy)
- **Performance-Optimierungen**: MPM Event Module, Gzip-Kompression, Browser-Caching
- **Konfigurationsspeicher**: Vollständiger phpMyAdmin-Konfigurationsspeicher (pmadb)
- **Metro-Design**: Modernes Standard-Design
- **Erweiterte Features**: Alle Features von 8.3 plus PHP 8.4-spezifische Optimierungen
- **Verbesserte Logs**: Emoji-basierte Statusmeldungen und erweiterte Protokollierung
- **Apache2-Optimierungen**: Thread-basierte Konfiguration für bessere Performance
- **Sichere Cookie-Verschlüsselung**: Automatisch generierter Blowfish-Secret

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
