
log_file=~/projects/plughub_calibrator/base.log
statistic_sh=~/projects/tools/statistic_calibr.sh


echo "last info A:"
sshpass -p 1111 ssh pi@plughub-calibrator-a.local $statistic_sh
sshpass -p 1111 ssh pi@plughub-calibrator-a.local tail -n -5 $log_file

echo
read -n1 -r -p "Press space to show log B:" key
echo 

echo "last info B:"
sshpass -p 1111 ssh pi@plughub-calibrator-b.local $statistic_sh
sshpass -p 1111 ssh pi@plughub-calibrator-b.local tail -n -5 $log_file

echo
read -n1 -r -p "Press space to show log D:" key
echo 

echo "last info D:"
sshpass -p 1111 ssh pi@plughub-calibrator-d.local $statistic_sh
sshpass -p 1111 ssh pi@plughub-calibrator-d.local tail -n -5 $log_file

read -n1 -r -p "Press spase to exit" key