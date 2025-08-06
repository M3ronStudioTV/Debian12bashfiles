#!/bin/bash

# Uninstall-Skript für phpMyAdmin 8.2 Installation
# Dieses Skript entfernt alle installierten Komponenten sauber

echo "=== phpMyAdmin 8.2 Uninstall-Skript ==="
echo "Dieses Skript wird alle installierten Komponenten entfernen."
echo ""

# Sicherheitsabfrage
read -p "Sind Sie sicher, dass Sie phpMyAdmin und alle zugehörigen Komponenten entfernen möchten? (j/N): " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Jj]$ ]]; then
    echo "Uninstall abgebrochen."
    exit 1
fi

echo "Starte Uninstall-Prozess..."

# 1. MySQL-Benutzer 'admin' entfernen
echo "Entferne MySQL-Benutzer 'admin'..."
mysql -e "DROP USER IF EXISTS 'admin'@'localhost'; FLUSH PRIVILEGES;" 2>/dev/null || echo "MySQL-Benutzer konnte nicht entfernt werden (möglicherweise nicht vorhanden)"

# 2. phpMyAdmin-Verzeichnis entfernen
echo "Entferne phpMyAdmin-Verzeichnis..."
if [ -d "/usr/share/phpmyadmin" ]; then
    rm -rf /usr/share/phpmyadmin
    echo "phpMyAdmin-Verzeichnis entfernt."
else
    echo "phpMyAdmin-Verzeichnis nicht gefunden."
fi

# 3. Apache-Konfiguration für phpMyAdmin entfernen
echo "Entferne Apache-Konfiguration..."
if [ -f "/etc/apache2/conf-available/phpmyadmin.conf" ]; then
    a2disconf phpmyadmin
    rm -f /etc/apache2/conf-available/phpmyadmin.conf
    systemctl reload apache2
    echo "Apache-Konfiguration entfernt."
else
    echo "Apache-Konfigurationsdatei nicht gefunden."
fi

# 4. phpMyAdmin-Daten-Datei entfernen
echo "Entferne phpMyAdmin-Daten-Datei..."
if [ -f "/home/phpmyadmin-data.txt" ]; then
    rm -f /home/phpmyadmin-data.txt
    echo "phpMyAdmin-Daten-Datei entfernt."
else
    echo "phpMyAdmin-Daten-Datei nicht gefunden."
fi

# 5. PHP 8.2 Pakete entfernen
echo "Entferne PHP 8.2 Pakete..."
apt remove --purge -y \
    php8.2 \
    php8.2-cli \
    php8.2-common \
    php8.2-curl \
    php8.2-gd \
    php8.2-intl \
    php8.2-mbstring \
    php8.2-mysql \
    php8.2-opcache \
    php8.2-readline \
    php8.2-xml \
    php8.2-xsl \
    php8.2-zip \
    php8.2-bz2 \
    libapache2-mod-php8.2

# 6. PHP 8.2 Repository entfernen
echo "Entferne PHP 8.2 Repository..."
if [ -f "/etc/apt/sources.list.d/php.list" ]; then
    rm -f /etc/apt/sources.list.d/php.list
    echo "PHP Repository entfernt."
fi

# 7. MariaDB entfernen (optional - mit Bestätigung)
echo ""
read -p "Möchten Sie auch MariaDB/MySQL entfernen? (j/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Jj]$ ]]; then
    echo "Entferne MariaDB/MySQL..."
    apt remove --purge -y mariadb-server mariadb-client
    apt autoremove -y
    echo "MariaDB/MySQL entfernt."
else
    echo "MariaDB/MySQL wird beibehalten."
fi

# 8. Apache2 entfernen (optional - mit Bestätigung)
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

# 9. Zusätzliche Pakete entfernen (optional - mit Bestätigung)
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

# 10. Nicht verwendete Pakete und Konfigurationsdateien entfernen
echo "Entferne nicht verwendete Pakete und Konfigurationsdateien..."
apt autoremove -y
apt autoclean

# 11. System aktualisieren
echo "Aktualisiere Paketlisten..."
apt update

echo ""
echo "=== Uninstall abgeschlossen ==="
echo "Alle phpMyAdmin 8.2 Komponenten wurden erfolgreich entfernt."
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