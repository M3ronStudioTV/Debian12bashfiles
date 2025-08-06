#!/bin/bash
# phpMyAdmin Installation Script mit PHP 8.4
# Aktualisiert für die neueste PHP-Version auf Debian/Ubuntu

# System aktualisieren und Upgrades durchführen
apt update && apt upgrade -y

# Benötigte Pakete installieren
apt install ca-certificates apt-transport-https lsb-release gnupg curl nano pwgen unzip software-properties-common -y

# PHP-Repository hinzufügen und PHP 8.4 installieren
wget -qO - https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /usr/share/keyrings/php.gpg
echo "deb [signed-by=/usr/share/keyrings/php.gpg] https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt update

# Apache2 installieren
apt install apache2 -y

# PHP 8.4 und alle benötigten Module installieren
apt install php8.4 php8.4-cli php8.4-common php8.4-curl php8.4-gd php8.4-intl php8.4-mbstring php8.4-mysql php8.4-opcache php8.4-readline php8.4-xml php8.4-xsl php8.4-zip php8.4-bz2 php8.4-fileinfo php8.4-json libapache2-mod-php8.4 -y

# MariaDB installieren und sichern
apt install mariadb-server mariadb-client -y

# MariaDB sichern
mysql_secure_installation <<EOF

y
1
1
y
y
y
y
EOF

# phpMyAdmin herunterladen und installieren
cd /usr/share
wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.zip -O phpmyadmin.zip
unzip phpmyadmin.zip
rm phpmyadmin.zip
mv phpMyAdmin-*-all-languages phpmyadmin
chmod -R 0755 phpmyadmin

cd /root/
clear

# Apache-Konfiguration für phpMyAdmin hinzufügen
cat > /etc/apache2/conf-available/phpmyadmin.conf << 'EOF'
Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
    Require all granted
    
    # Erweiterte Sicherheitsheader für PHP 8.4
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options DENY
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
    Header always set Permissions-Policy "geolocation=(), microphone=(), camera=()"
</Directory>

<Directory /usr/share/phpmyadmin/templates>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/libraries>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/lib>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/setup/frames>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/locale>
    Require all denied
</Directory>
<Directory /usr/share/phpmyadmin/vendor>
    Require all denied
</Directory>
EOF

# Apache-Module aktivieren
a2enmod headers
a2enconf phpmyadmin
systemctl reload apache2
clear

# Temporäres Verzeichnis für phpMyAdmin erstellen und Berechtigungen setzen
mkdir -p /usr/share/phpmyadmin/tmp/
chown -R www-data:www-data /usr/share/phpmyadmin/tmp/
chmod 755 /usr/share/phpmyadmin/tmp/

# MySQL konfigurieren und Benutzer erstellen
PASS=$(pwgen -s 40 1)
USERNAME=$(pwgen -s 8 1)

mysql <<MYSQL_SCRIPT
CREATE USER 'admin'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# IP-Adresse des Servers ermitteln
ip=$(hostname -I | awk '{print $1}')

# Zugangsdaten in eine Datei schreiben
cat > /home/phpmyadmin-data.txt << EOF
######### PHPMYADMIN Zugang #########
User: admin
Passwort: $PASS
Link: http://$ip/phpmyadmin
PHP Version: $(php -v | head -n1)
Installationsdatum: $(date)
PHP 8.4 Features: Neue JIT-Engine, verbesserte Performance
EOF

# Berechtigungen für die Daten-Datei setzen
chmod 600 /home/phpmyadmin-data.txt

echo "=========================================="
echo "phpMyAdmin Installation mit PHP 8.4 abgeschlossen!"
echo "=========================================="
echo "PHP Version: $(php -v | head -n1)"
echo "Zugangsdaten finden Sie in: /home/phpmyadmin-data.txt"
echo "phpMyAdmin URL: http://$ip/phpmyadmin"
echo "=========================================="

# Zugangsdaten (bitte ggf. anpassen)
PMADB_USER="admin"
PMADB_PASS="$(grep 'Passwort:' /home/phpmyadmin-data.txt | awk '{print $2}')"
PMADB_DB="phpmyadmin"

# Datenbank und Rechte anlegen
mysql -u root <<MYSQL_SCRIPT
CREATE DATABASE IF NOT EXISTS $PMADB_DB DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
GRANT ALL PRIVILEGES ON $PMADB_DB.* TO '$PMADB_USER'@'localhost' IDENTIFIED BY '$PMADB_PASS';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# Tabellenstruktur importieren (aus dem offiziellen phpMyAdmin-SQL-Skript)
SQL_FILE="/usr/share/phpmyadmin/sql/create_tables.sql"
if [ -f "$SQL_FILE" ]; then
    mysql -u root $PMADB_DB < "$SQL_FILE"
else
    echo "Fehler: $SQL_FILE nicht gefunden! Bitte prüfen Sie die phpMyAdmin-Installation."
    exit 1
fi

# config.inc.php anpassen (pmadb-Features aktivieren)
cat >> /usr/share/phpmyadmin/config.inc.php <<EOF

// Sicherer Schlüssel für Cookie-Verschlüsselung (PHP 8.4 optimiert)
\$cfg['blowfish_secret'] = '$(openssl rand -base64 32)';

// Standard-Design auf Metro setzen
\$cfg['ThemeDefault'] = 'metro';
\$cfg['ThemeManager'] = true;

// PHP 8.4 Optimierungen
\$cfg['LoginCookieValidity'] = 1440;
\$cfg['LoginCookieStore'] = 0;
\$cfg['LoginCookieDeleteAll'] = true;

// Konfigurationsspeicher für erweiterte Features
\$cfg['Servers'][1]['controluser'] = '$PMADB_USER';
\$cfg['Servers'][1]['controlpass'] = '$PMADB_PASS';
\$cfg['Servers'][1]['pmadb'] = '$PMADB_DB';
\$cfg['Servers'][1]['bookmarktable'] = 'pma__bookmark';
\$cfg['Servers'][1]['relation'] = 'pma__relation';
\$cfg['Servers'][1]['table_info'] = 'pma__table_info';
\$cfg['Servers'][1]['table_coords'] = 'pma__table_coords';
\$cfg['Servers'][1]['pdf_pages'] = 'pma__pdf_pages';
\$cfg['Servers'][1]['column_info'] = 'pma__column_info';
\$cfg['Servers'][1]['history'] = 'pma__history';
\$cfg['Servers'][1]['table_uiprefs'] = 'pma__table_uiprefs';
\$cfg['Servers'][1]['tracking'] = 'pma__tracking';
\$cfg['Servers'][1]['userconfig'] = 'pma__userconfig';
\$cfg['Servers'][1]['recent'] = 'pma__recent';
\$cfg['Servers'][1]['favorite'] = 'pma__favorite';
\$cfg['Servers'][1]['users'] = 'pma__users';
\$cfg['Servers'][1]['usergroups'] = 'pma__usergroups';
\$cfg['Servers'][1]['navigationhiding'] = 'pma__navigationhiding';
\$cfg['Servers'][1]['savedsearches'] = 'pma__savedsearches';
\$cfg['Servers'][1]['central_columns'] = 'pma__central_columns';
\$cfg['Servers'][1]['designer_settings'] = 'pma__designer_settings';
\$cfg['Servers'][1]['export_templates'] = 'pma__export_templates';

// PHP 8.4 Performance-Optimierungen
\$cfg['MemoryLimit'] = '256M';
\$cfg['MaxExecutionTime'] = 300;
\$cfg['MaxInputTime'] = 300;
\$cfg['PostMaxSize'] = '64M';
\$cfg['UploadMaxFileSize'] = '64M';
EOF

# PHP 8.4 spezifische Optimierungen
echo "=========================================="
echo "PHP 8.4 Optimierungen werden angewendet..."
echo "=========================================="

# PHP-FPM Konfiguration optimieren (falls installiert)
if [ -f "/etc/php/8.4/fpm/php.ini" ]; then
    sed -i 's/memory_limit = 128M/memory_limit = 256M/' /etc/php/8.4/fpm/php.ini
    sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/php/8.4/fpm/php.ini
    sed -i 's/opcache.enable=1/opcache.enable=1/' /etc/php/8.4/fpm/php.ini
    sed -i 's/opcache.memory_consumption=128/opcache.memory_consumption=256/' /etc/php/8.4/fpm/php.ini
    systemctl restart php8.4-fpm
fi

# Apache2 Performance-Optimierungen
echo "=========================================="
echo "Apache2 Performance-Optimierungen..."
echo "=========================================="

# MPM Event Module aktivieren für bessere Performance
a2enmod mpm_event
a2dismod mpm_prefork

# Apache2 Konfiguration optimieren
cat >> /etc/apache2/apache2.conf << 'EOF'

# PHP 8.4 Performance-Optimierungen
<IfModule mpm_event_module>
    StartServers 2
    MinSpareThreads 25
    MaxSpareThreads 75
    ThreadLimit 64
    ThreadsPerChild 25
    MaxRequestWorkers 150
    MaxConnectionsPerChild 0
</IfModule>

# Gzip Kompression aktivieren
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>

# Browser-Caching aktivieren
<IfModule mod_expires.c>
    ExpiresActive On
    ExpiresByType text/css "access plus 1 month"
    ExpiresByType application/javascript "access plus 1 month"
    ExpiresByType image/png "access plus 1 month"
    ExpiresByType image/jpg "access plus 1 month"
    ExpiresByType image/jpeg "access plus 1 month"
    ExpiresByType image/gif "access plus 1 month"
    ExpiresByType image/ico "access plus 1 month"
</IfModule>
EOF

# Apache2 neu laden
systemctl reload apache2

echo "=========================================="
echo "phpMyAdmin Konfigurationsspeicher (pmadb) wurde erfolgreich eingerichtet!"
echo "PHP 8.4 Optimierungen wurden angewendet!"
echo "Bitte phpMyAdmin im Browser neu laden, um alle Features zu nutzen."
echo "=========================================="

# Finale Statusmeldung
echo "---------------------------------------------------------------------------------------------"
echo "-- ______  ___                        ____________       _____________      __________    __ "
echo "-- ___   |/  /__________________________  ___/_  /____  _______  /__(_)________  __/_ |  / / "
echo "-- __  /|_/ /_  _ \_  ___/  __ \_  __ \____ \_  __/  / / /  __  /__  /_  __ \_  /  __ | / /  "
echo "-- _  /  / / /  __/  /   / /_/ /  / / /___/ // /_ / /_/ // /_/ / _  / / /_/ /  /   __ |/ /   "	
echo "-- /_/  /_/  \___//_/    \____//_/ /_//____/ \__/ \__,_/ \__,_/  /_/  \____//_/    _____/    "
echo "---------------------------------------------------------------------------------------------"
echo "=========================================="
echo "Installation erfolgreich abgeschlossen!"
echo "=========================================="
echo "✅ PHP 8.4 installiert und konfiguriert"
echo "✅ Apache2 mit Performance-Optimierungen"
echo "✅ MariaDB sicher konfiguriert"
echo "✅ phpMyAdmin mit erweiterten Features"
echo "✅ Konfigurationsspeicher aktiviert"
echo "✅ Sicherheitsheader implementiert"
echo "=========================================="
echo "📋 Zugangsdaten: /home/phpmyadmin-data.txt"
echo "🌐 URL: http://$ip/phpmyadmin"
echo "==========================================" 