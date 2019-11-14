#!/bin/bash

echo "Factory server statistic:"

TOTAL=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device" -A -t 2> /dev/null)

TOTAL_ASSIGNED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't'" -A -t 2> /dev/null)

TOTAL_FAILED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f'" -A -t 2> /dev/null)
TOTAL_PROVISION_NOT_COMPLETED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE provision_completed = 'f'" -A -t 2> /dev/null)
TOTAL_PROVISION_COMPLETED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE provision_completed = 't'" -A -t 2> /dev/null)

TOTAL_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE DATE('creation_time') = DATE(CURDATE())" -A -t 2> /dev/null)

ASSIGNED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't' AND DATE(creation_time)=CURDATE()" -A -t 2> /dev/null)

FAILED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f' AND DATE(creation_time)=CURDATE()" -A -t 2> /dev/null)
#                   sudo -u postgres psql -d device_provisioning -c "SELECT creation_time FROM device ORDER BY device_id DESC LIMIT 1" -A -t 2>/dev/null
LAST_RECORT_DATE=$(sudo -u postgres psql -d  device_provisioning -c "SELECT creation_time  FROM device ORDER BY device_id DESC LIMIT 1" -A -t 2> /dev/null)

dt=` date '+%Y-%m-%d %H:%M:%S'`
echo "Date: $dt"
#echo "___________________________"
echo "Total: $TOTAL" 
echo "Total assigned: $TOTAL_ASSIGNED"
echo "Total not assigned: $TOTAL_FAILED"

echo "Total provision completted: $TOTAL_PROVISION_COMPLETED"
echo "Total provision not completted: $TOTAL_PROVISION_NOT_COMPLETED"

#echo "___________________________"
#echo "Today total: $TOTAL_TODAY" 
#echo "Today assigned: $ASSIGNED_TODAY"
#echo "Today failed: $FAILED_TODAY"

#LAST_RECORT_DATE="${LAST_RECORT_DATE%.*}"

echo "Last provision date: "${LAST_RECORT_DATE%.*}""
