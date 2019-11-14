#!/bin/bash

echo "Factory server statistic:"

TOTAL=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device" -A -t 2> /dev/null)

TOTAL_ASSIGNED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't'" -A -t 2> /dev/null)

TOTAL_FAILED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f'" -A -t 2> /dev/null)

TOTAL_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't' DATE(date)=CURDATE()" -A -t 2> /dev/null)

ASSIGNED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't'" -A -t 2> /dev/null)

FAILED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f'" -A -t 2> /dev/null)


echo "___________________________"
echo "Total: $TOTAL" 
echo "Total assigned: $TOTAL_ASSIGNED"
echo "Total failed: $TOTAL_FAILED"
echo "___________________________"
echo "Today total: $TOTAL" 
echo "Today assigned: $TOTAL_ASSIGNED"
echo "Today failed: $TOTAL_FAILED"      

