#!/bin/bash

echo "Execute factory server monitor"

NOT_ASSIGNED_MAX_NUM=5

NOT_ASSIGNED_STR=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't' DATE(date)=CURDATE()" -A -t 2> /dev/null)

NOT_ASSIGNED_NUM=$((NOT_ASSIGNED_STR))

if [ $NOT_ASSIGNED_NUM -gt $NOT_ASSIGNED_MAX_NUM ]
then
    echo "Restart cloud client service.."
    sudo systemctl restart cloud_client.service
fi