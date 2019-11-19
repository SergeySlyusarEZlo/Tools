#!/bin/bash

indexes="a b c d e"
log_file=projects/atom32_provisioning/base.log
HOST_PREFIX=pi@plughub-provisioner

wait_key_press(){
   echo "Show more.."
   read -n1 -r -p "Press and key" key
}

full_info(){
  sshpass -p 1111 ssh $HOST_PREFIX-$1.local tail -n -5 $log_file
}

extendedInfo(){
    for index in $indexes; 
      do
        echo "Detail info calibrator ${index^^}:"
        full_info ${index}
        wait_key_press
       done
}

#main:
echo "Factory server statistic:"
TOTAL=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device" -A -t 2> /dev/null)
TOTAL_ASSIGNED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't'" -A -t 2> /dev/null)
TOTAL_FAILED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f'" -A -t 2> /dev/null)
TOTAL_PROVISION_NOT_COMPLETED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE provision_completed = 'f'" -A -t 2> /dev/null)
TOTAL_PROVISION_COMPLETED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE provision_completed = 't'" -A -t 2> /dev/null)

#TOTAL_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE DATE('creation_time') = DATE(CURDATE())" -A -t 2> /dev/null)
#ASSIGNED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 't' AND DATE(creation_time)=CURDATE()" -A -t 2> /dev/null)
#FAILED_TODAY=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM device WHERE assigned = 'f' AND DATE(creation_time)=CURDATE()" -A -t 2> /dev/null)

sudo -u postgres psql -d device_provisioning -c "SELECT creation_time FROM device ORDER BY device_id DESC LIMIT 1" -A -t 2>/dev/null

LAST_RECORT_DATE=$(sudo -u postgres psql -d  device_provisioning -c "SELECT creation_time  FROM device ORDER BY device_id DESC LIMIT 1" -A -t 2> /dev/null)

dt=` date '+%Y-%m-%d %H:%M:%S'`
echo "Date: $dt"
#echo "___________________________"
echo "Device:"
echo "Total: $TOTAL" 
echo "Total assigned: $TOTAL_ASSIGNED"
echo "Total not assigned: $TOTAL_FAILED"

echo "Total provision completted: $TOTAL_PROVISION_COMPLETED"
echo "Total provision not completted: $TOTAL_PROVISION_NOT_COMPLETED"
echo "Last provision date: "${LAST_RECORT_DATE%.*}""

wait_key_press

echo "Tests:"
TOTAL_TESTS=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM test" -A -t 2> /dev/null)
TOTAL_TESTS_SUCSES=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM test WHERE test_result = 't'" -A -t 2> /dev/null)
TOTAL_TESTS_FAILED=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM test WHERE test_result = 'f'" -A -t 2> /dev/null)
TOTAL_TEST_NO_SENT_TO_SERVER=$(sudo -u postgres psql -d device_provisioning -c "SELECT count(*) FROM test WHERE sent_to_server = 'f'" -A -t 2> /dev/null)

echo "Total:" $TOTAL_TESTS
echo "Total succces:" $TOTAL_TESTS_SUCSES
echo "Total failed:" $TOTAL_TESTS_FAILED
echo "Total does't sent to server:" $TOTAL_TEST_NO_SENT_TO_SERVER
#echo "___________________________"
#echo "Today total: $TOTAL_TODAY" 
#echo "Today assigned: $ASSIGNED_TODAY"
#echo "Today failed: $FAILED_TODAY"
#LAST_RECORT_DATE="${LAST_RECORT_DATE%.*}"


#wait_key_press
#extendedInfo


