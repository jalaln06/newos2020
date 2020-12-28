prevbackfilename=$(ls /home/user | grep "Backup" | sort -n | tail -1)
if [[  "$prevbackfilename" == "" ]]; then
    echo "NO BACK_UPS FOUND !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    exit 1
fi

if [[ ! -d /home/user/restore ]]; then
    mkdir /home/user/restore
fi
filelistback=$(ls /home/user/$prevbackfilename)
regex='[0-9]{4}-[0-9]{2}-[0-9]{2}'
for LINE in $filelistback; do
    

    if [[ $LINE =~ $regex ]]; then
        :
    else
        cp /home/user/$prevbackfilename/$LINE /home/user/restore
    fi

done