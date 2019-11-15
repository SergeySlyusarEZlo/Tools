
log_file=projects/plughub_calibrator/base.log
statistic_sh=projects/tools/statistic_calibr.sh


HOST_PREFIX=pi@plughub-calibrator

indexes="a b d"

all(){
  res=$(sshpass -p 1111 ssh $HOST_PREFIX-$1.local grep -wc "Start" $log_file)
  echo $res
}

succsess(){
  res=$(sshpass -p 1111 ssh $HOST_PREFIX-$1.local grep -wc "OK" $log_file)
  echo $res
}

summary(){
	total=0
	total_succsess=0

  echo "Calibration statistic:"
	for index in $indexes; 
      do
      	all_by_index=$(all ${index})
        total=$(($total + $all_by_index))

        succsess_by_index=$(succsess ${index})
        total_succsess=$(($total_succsess + $succsess_by_index)) 
       done

    echo "Total:" $total
    echo "Succsess:" $total_succsess
    echo "Fail:" $(($total - $total_succsess))
}

extendedInfo(){
	for index in $indexes; 
      do
        echo "Detail info calibrator ${index^^}:"
        full_info ${index}
        wait_key_press
       done
}

full_info(){

  sshpass -p 1111 ssh $HOST_PREFIX-$1.local $statistic_sh
  sshpass -p 1111 ssh $HOST_PREFIX-$1.local tail -n -5 $log_file
}

wait_key_press(){
   echo
   read -n1 -r -p "Press and key" key
   echo
}

#main:
summary
echo "Show more.."
wait_key_press
extendedInfo
