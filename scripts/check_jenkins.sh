#!/bin/bash
SERVICE="jenkins"
EMAIL="test@mail.com"
DATE=$(date)
if systemctl is-active --quiet $SERVICE; then
   echo "$DATE: $SERVICE is running"
else
   echo "$DATE: $SERVICE is NOT running, restarting..."
   sudo systemctl restart $SERVICE
   echo "$SERVICE was down and restarted on $(hostname)" | mail -s "$SERVICE Restart Alert" $EMAIL
fi
