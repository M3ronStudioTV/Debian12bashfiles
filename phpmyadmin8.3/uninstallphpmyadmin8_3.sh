#!/bin/bash

# Uninstall-Skript für PHP 8.3 Installation
# Dieses Skript entfernt alle installierten Komponenten sauber

echo "=== PHP 8.3 Uninstall-Skript ==="
echo "Dieses Skript wird alle installierten Komponenten entfernen."
echo ""

# Sicherheitsabfrage
read -p "Sind Sie sicher, dass Sie PHP 8.3 und alle zugehörigen Komponenten entfernen möchten? (j/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Jj]$ ]]; then
    echo "Uninstall abgebrochen."
    exit 1
fi

echo "Starte Uninstall-Prozess..."

# 1. PHP 8.3 Pakete entfernen
echo "Entferne PHP 8.3 Pakete..."
apt remove --purge -y \
    php8.3 \
    php8.3-cli \
    php8.3-common \
    php8.3-curl \
    php8.3-gd \
    php8.3-intl \
    php8.3-mbstring \
    php8.3-mysql \
    php8.3-opcache \
    php8.3-readline \
    php8.3-xml \
    php8.3-xsl \
    php8.3-zip \
    php8.3-bz2 \
    libapache2-mod-php8.3

# 2. PHP 8.3 Repository entfernen
echo "Entferne PHP 8.3 Repository..."
if [ -f "/etc/apt/sources.list.d/php.list" ]; then
    rm -f /etc/apt/sources.list.d/php.list
    echo "PHP Repository entfernt."
else
    echo "PHP Repository-Datei nicht gefunden."
fi

# 3. PHP 8.3 Konfigurationsdateien entfernen
echo "Entferne PHP 8.3 Konfigurationsdateien..."
if [ -d "/etc/php/8.3" ]; then
    rm -rf /etc/php/8.3
    echo "PHP 8.3 Konfigurationsverzeichnis entfernt."
else
    echo "PHP 8.3 Konfigurationsverzeichnis nicht gefunden."
fi

# 4. PHP 8.3 Symlinks entfernen
echo "Entferne PHP 8.3 Symlinks..."
if [ -f "/etc/alternatives/php" ]; then
    rm -f /etc/alternatives/php
    echo "PHP Symlink entfernt."
else
    echo "PHP Symlink nicht gefunden."
fi

if [ -f "/etc/alternatives/php-config" ]; then
    rm -f /etc/alternatives/php-config
    echo "PHP-Config Symlink entfernt."
else
    echo "PHP-Config Symlink nicht gefunden."
fi

if [ -f "/etc/alternatives/phpize" ]; then
    rm -f /etc/alternatives/phpize
    echo "PHPize Symlink entfernt."
else
    echo "PHPize Symlink nicht gefunden."
fi

# 5. Apache PHP-Modul entfernen (falls Apache läuft)
echo "Entferne Apache PHP-Modul..."
if systemctl is-active --quiet apache2; then
    a2dismod php8.3 2>/dev/null || echo "PHP 8.3 Modul war nicht aktiviert"
    systemctl reload apache2
    echo "Apache-Konfiguration neu geladen."
else
    echo "Apache läuft nicht."
fi

# 6. PHP-FPM Service stoppen und entfernen (falls vorhanden)
echo "Stoppe PHP-FPM Service..."
if systemctl is-active --quiet php8.3-fpm; then
    systemctl stop php8.3-fpm
    systemctl disable php8.3-fpm
    echo "PHP-FPM Service gestoppt und deaktiviert."
else
    echo "PHP-FPM Service läuft nicht."
fi

# 7. PHP 8.3 Log-Dateien entfernen
echo "Entferne PHP 8.3 Log-Dateien..."
if [ -f "/var/log/php8.3-*" ]; then
    rm -f /var/log/php8.3-*
    echo "PHP 8.3 Log-Dateien entfernt."
else
    echo "PHP 8.3 Log-Dateien nicht gefunden."
fi

# 8. PHP 8.3 Cache-Verzeichnisse entfernen
echo "Entferne PHP 8.3 Cache-Verzeichnisse..."
if [ -d "/var/lib/php/sessions" ]; then
    rm -rf /var/lib/php/sessions
    echo "PHP Sessions-Verzeichnis entfernt."
else
    echo "PHP Sessions-Verzeichnis nicht gefunden."
fi

if [ -d "/var/lib/php/opcache" ]; then
    rm -rf /var/lib/php/opcache
    echo "PHP OpCache-Verzeichnis entfernt."
else
    echo "PHP OpCache-Verzeichnis nicht gefunden."
fi

# 9. PHP 8.3 Binärdateien entfernen
echo "Entferne PHP 8.3 Binärdateien..."
if [ -f "/usr/bin/php8.3" ]; then
    rm -f /usr/bin/php8.3
    echo "PHP 8.3 Binärdatei entfernt."
else
    echo "PHP 8.3 Binärdatei nicht gefunden."
fi

if [ -f "/usr/bin/php-config8.3" ]; then
    rm -f /usr/bin/php-config8.3
    echo "PHP-Config 8.3 Binärdatei entfernt."
else
    echo "PHP-Config 8.3 Binärdatei nicht gefunden."
fi

if [ -f "/usr/bin/phpize8.3" ]; then
    rm -f /usr/bin/phpize8.3
    echo "PHPize 8.3 Binärdatei entfernt."
else
    echo "PHPize 8.3 Binärdatei nicht gefunden."
fi

# 10. Apache2 entfernen (optional - mit Bestätigung)
echo ""
read -p "Möchten Sie auch Apache2 entfernen? (j/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Jj]$ ]]; then
    echo "Entferne Apache2..."
    apt remove --purge -y apache2
    apt autoremove -y
    echo "Apache2 entfernt."
else
    echo "Apache2 wird beibehalten."
fi

# 11. Zusätzliche Pakete entfernen (optional - mit Bestätigung)
echo ""
read -p "Möchten Sie auch die zusätzlichen Pakete (ca-certificates, apt-transport-https, lsb-release, gnupg, curl, nano, pwgen, unzip) entfernen? (j/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Jj]$ ]]; then
    echo "Entferne zusätzliche Pakete..."
    apt remove --purge -y ca-certificates apt-transport-https lsb-release gnupg curl nano pwgen unzip
    apt autoremove -y
    echo "Zusätzliche Pakete entfernt."
else
    echo "Zusätzliche Pakete werden beibehalten."
fi

# 12. Nicht verwendete Pakete und Konfigurationsdateien entfernen
echo "Entferne nicht verwendete Pakete und Konfigurationsdateien..."
apt autoremove -y
apt autoclean

# 13. System aktualisieren
echo "Aktualisiere Paketlisten..."
apt update

echo ""
echo "=== Uninstall abgeschlossen ==="
echo "Alle PHP 8.3 Komponenten wurden erfolgreich entfernt."
echo ""
echo "Hinweise:"
echo "- Überprüfen Sie, ob andere Dienste von den entfernten Paketen abhängig waren"
echo "- Führen Sie bei Bedarf 'apt autoremove' aus, um weitere nicht verwendete Pakete zu entfernen"
echo "- Starten Sie das System neu, falls erforderlich" 
echo "---------------------------------------------------------------------------------------------"
echo "-- ______  ___                        ____________       _____________      __________    __ "
echo "-- ___   |/  /__________________________  ___/_  /____  _______  /__(_)________  __/_ |  / / "
echo "-- __  /|_/ /_  _ \_  ___/  __ \_  __ \____ \_  __/  / / /  __  /__  /_  __ \_  /  __ | / /  "
echo "-- _  /  / / /  __/  /   / /_/ /  / / /___/ // /_ / /_/ // /_/ / _  / / /_/ /  /   __ |/ /   "	
echo "-- /_/  /_/  \___//_/    \____//_/ /_//____/ \__/ \__,_/ \__,_/  /_/  \____//_/    _____/    "
echo "---------------------------------------------------------------------------------------------"
