#!/bin/bash
# Script de aprovisionamiento - TechSolutions S.A.
# Equipo: [Romina Sanchez] | Materia: Sistemas Operativos
# Fecha: [14-abril-2026]

set -e

echo '=============================='
echo ' APROVISIONAMIENTO TECHSOLUTIONS'
echo '=============================='

# 1. Actualizacion del sistema
echo '[1/6] Actualizando sistema...'
apt-get update -qq && apt-get upgrade -y -qq

# 2. Instalar Apache (servidor web)
echo '[2/6] Instalando Apache...'
apt-get install -y apache2
systemctl enable apache2 && systemctl start apache2

# 3. Instalar MySQL
echo '[3/6] Instalando MySQL...'
apt-get install -y mysql-server
systemctl enable mysql && systemctl start mysql

# 4. Instalar PHP
echo '[4/6] Instalando PHP...'
apt-get install -y php libapache2-mod-php php-mysql

# 5. Instalar y configurar FTP (vsftpd)
echo '[5/6] Configurando FTP...'apt-get install -y vsftpd
sudo addusser ftpuser
sudo mkdir -p /home/ftpuser/fpt/upload
sudo chown nobody:nogroup /home/ftpuser/ftp
sudo chown ftpuser:ftpuser /home/ftpuser/ftp/upload

# 6. Configurar SSH
echo '[6/6] Configurando SSH...'
apt-get install -y openssh-server

systemctl enable ssh
systemctl start ssh

echo 'Aprovisionamiento completado exitosamente.'
