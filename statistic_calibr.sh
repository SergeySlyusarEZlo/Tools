
log_file=~/projects/plughub_calibrator/base.log
TOTAL=$(grep -wc "Start calibrate.." $log_file)
TOTAL_SUCCSES=$(grep -wc "Calibrate OK" $log_file)
TOTAL_FAILED=$(($TOTAL - $TOTAL_SUCCSES))
last_row=$(tail -n 1 $log_file)
last_calibration_date=${last_row%%,*}
dt=` date '+%d-%m-%Y %H:%M:%S'`

echo 
echo "Calibration statistics:"
echo "Date:" $dt
echo "Total:" $TOTAL
echo "Total succses:" $TOTAL_SUCCSES
echo "Total failed:" $TOTAL_FAILED
echo "Last calibration date:" $last_calibration_date
echo
