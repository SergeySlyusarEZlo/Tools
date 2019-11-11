
SUBJECT="Proivision data statistic"
RECIPIENTS="serg.fly@gmail.com,sergey.slyusar@ezlo.com"

GET_STATISTIC=~/projects/tools/statistic.sh
OUT_STATISIC=~/projects/tools/.out_stat
DB_DATE_SAVE_FILE=~/projects/tools/.db_save

send_mail() {
     current_db_date=$( tail -n 1 $OUT_STATISIC )
     echo $current_db_date > $DB_DATE_SAVE_FILE
     sudo mail -s "$SUBJECT" $RECIPIENTS < $OUT_STATISIC
    }

sudo $GET_STATISTIC > $OUT_STATISIC

if [ -f $DB_DATE_SAVE_FILE ]; then
   saved_db_date=$(<$DB_DATE_SAVE_FILE)

   echo $saved_db_date
   current_db_date=$( tail -n 1 $OUT_STATISIC )
   current_db_date=${current_db_date::-1}
   if [ "$current_db_date" != "$saved_db_date" ]; then
       send_mail
   fi
else
    send_mail
fi
