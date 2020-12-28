now=$(date +'%Y-%m-%d')
prevbackfilename=$(ls /home/user | grep "Backup" | sort -n | tail -1)
prevback=$(ls /home/user | grep "Backup" | sed -e 's/Backup-//g' | sort -n | tail -1)
nowassec=$(date -d "$now" +%s )
prevassec=$(date -d "$prevback" +%s )
timediff=$(($nowassec - $prevassec))
let timediff=$timediff/60/60/24
echo "new files to be added:" > tempnew
echo "old files to be renamed:" > tempold
if [[ $timediff -lt 7 ]]; then
    filelistback=$(ls /home/user/$prevbackfilename)
    filelistsource=$(ls /home/user/source)
    echo "Catalogue Backup-$now was created succesfully" >> /home/user/backup-report
    for LINE2 in $filelistsource; do
        if [[ ! -f /home/user/$prevbackfilename/$LINE2 ]]; then
            cp /home/user/source/$LINE2 /home/user/$prevbackfilename
            echo "$LINE2 was added to catalogue" >> tempnew
        else 
            size1=$(stat -c %s "/home/user/source/$LINE2")
            size2=$(stat -c %s "/home/user/$prevbackfilename/$LINE2")
            if [[ ! size1 -eq size2 ]]; then
                cp /home/user/$prevbackfilename/$LINE2 /home/user/$prevbackfilename/$LINE2.$now
                echo "old file name : $LINE2 new file name: $LINE2.$now" >> tempold
                rm /home/user/$prevbackfilename/$LINE2 
                cp /home/user/source/$LINE2 /home/user/$prevbackfilename 
                echo "$LINE2" >> tempnew  
            fi
        fi
    done
    cat tempnew >> /home/user/backup-report
    cat tempold >> /home/user/backup-report
    rm tempnew
    rm tempold
else
    mkdir /home/user/Backup-$now
    cp -a /home/user/source/. /home/user/Backup-$now
    echo "Catalogue Backup-$now was created succesfully" >> /home/user/backup-report
    ls /home/user/source >> /home/user/backup-report
fi
