#!/bin/bash
# Script de monitoreo - TechSolutions S.A.

LOG='/var/log/techsolutions_monitor.log'
UMBRAL_CPU=80
FECHA=$(date '+%Y-%m-%d %H:%M:%S')

# CPU
CPU=$(top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1)
# RAM
RAM=$(free -m | awk 'NR==2{printf "%.1f%%", $3*100/$2}')
# Disco
DISCO=$(df -h / | awk 'NR==2{print $5}')
# Red (bytes recibidos en la interfaz principal)
RED=$(cat /proc/net/dev | grep enp0s3 | awk '{print $2}')

echo "[$FECHA] CPU: $CPU% RAM: $RAM Disco: $DISCO Red_RX: $RED bytes" >> $LOG

# Alerta si CPU supera el umbral
if (( $(echo "$CPU > $UMBRAL_CPU" | bc -l) )); then
 echo "[$FECHA] ALERTA: CPU al $CPU% - supera umbral de $UMBRAL_CPU%" >> $LOG
 echo "ALERTA CPU ALTA: $CPU%" | wall # mensaje a todos los usuarios
fi
