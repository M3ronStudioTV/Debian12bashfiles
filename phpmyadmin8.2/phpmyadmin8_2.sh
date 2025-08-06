
# System aktualisieren und Upgrades durchführen
apt update && apt upgrade -y

# Benötigte Pakete installieren
apt install ca-certificates apt-transport-https lsb-release gnupg curl nano pwgen unzip -y

# PHP-Repository hinzufügen und PHP 7.4 installieren
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/php.list
apt update
apt install apache2 -y
apt install php8.2 php8.2-cli php8.2-common php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-mysql php8.2-opcache php8.2-readline php8.2-xml php8.2-xsl php8.2-zip php8.2-bz2 libapache2-mod-php8.2 -y

# MariaDB installieren
apt install mariadb-server mariadb-client -y

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
echo -e '
Alias /phpmyadmin /usr/share/phpmyadmin

<Directory /usr/share/phpmyadmin>
    Options SymLinksIfOwnerMatch
    DirectoryIndex index.php
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
' >> /etc/apache2/conf-available/phpmyadmin.conf

a2enconf phpmyadmin
systemctl reload apache2
clear

# Temporäres Verzeichnis für phpMyAdmin erstellen und Berechtigungen setzen
mkdir /usr/share/phpmyadmin/tmp/
chown -R www-data:www-data /usr/share/phpmyadmin/tmp/

# MySQL konfigurieren und Benutzer erstellen
PASS=`pwgen -s 40 1`
USERNAME=`pwgen -s 8 1`
mysql <<MYSQL_SCRIPT
CREATE USER 'admin'@'localhost' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;
MYSQL_SCRIPT

# IP-Adresse des Servers ermitteln und Daten in eine Datei schreiben
ip=$(hostname -i)


touch /home/phpmyadmin-data.txt

echo "---------------------------------------------------------------------------------------------"
echo "-- ______  ___                        ____________       _____________      __________    __ "
echo "-- ___   |/  /__________________________  ___/_  /____  _______  /__(_)________  __/_ |  / / "
echo "-- __  /|_/ /_  _ \_  ___/  __ \_  __ \____ \_  __/  / / /  __  /__  /_  __ \_  /  __ | / /  "
echo "-- _  /  / / /  __/  /   / /_/ /  / / /___/ // /_ / /_/ // /_/ / _  / / /_/ /  /   __ |/ /   "	
echo "-- /_/  /_/  \___//_/    \____//_/ /_//____/ \__/ \__,_/ \__,_/  /_/  \____//_/    _____/    "
echo "---------------------------------------------------------------------------------------------"
echo -e "######### PHPMYADMIN Zugang #########" >> /home/phpmyadmin-data.txt
echo -e "User: admin" >> /home/phpmyadmin-data.txt
echo -e "Passwort: $PASS" >> /home/phpmyadmin-data.txt
echo -e "Link: http://"$ip"/phpmyadmin" >> /home/phpmyadmin-data.txt

echo 'Sie finden ihre PHPMYADMIN zugangsdaten in ihren FTP/SFTP zugang in /home'
