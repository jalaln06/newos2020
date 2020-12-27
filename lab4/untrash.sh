filename=$1
IFS=$'\n'

recover () {
    FileLocation=$(echo "$1" | awk '{ print $1 }' )
    FileNumber=$(echo "$1" | awk '{ print $5 }' )
    if [[ -d $FileLocation ]]; then
        if [[ -e $FileLocation/$2 ]]; then
            echo "Enter another name for file!"
            read INPUT
            mv /home/user/.trash/$FileNumber $FileLocation/$INPUT
        else
            mv /home/user/.trash/$FileNumber $FileLocation/$2
        fi
    else
        echo "Location doesn't exist"
        if [[ -e /home/user/$2 ]]; then
            echo "Enter another name for file!"
            read INPUT
            mv /home/user/.trash/$FileNumber /home/user/$INPUT
        else
            mv /home/user/.trash/$FileNumber /home/user/$2
        fi
    fi  
}




if [[ $# != 1 ]]; then
    echo "Enter filename"
    exit 1
fi

if [[ ! -f /home/user/.trashlog ]]; then
    echo "TRASHlog NOT FOUND RUN RMTRASH FIRST"
    exit 2
fi

if [[ ! -e /home/user/.trash ]]; then
    echo "TRASH DIRECTORY NOT FOUND RUN RMTRASH FIRST"
    exit 3
fi

if [[ -z $(grep "$1" /home/user/.trashlog) ]]; then
	echo "YOUR FILE DOESNT EXIST IN TRASHLOG"
	exit 4
fi
trashlog="/home/user/.trashlog"
temp=$(grep "$1" "$trashlog" )
temp1=$(grep "$1" "$trashlog" )
filename=$1

sed -i "/ $filename /d" "$trashlog"  
for LINE in $temp ; do
    echo "$LINE"
    echo "Do you want to recover upper file? [Y/N]"
    read INPUT
    case $INPUT in
        "Y")
        recover "$LINE" "$filename"
        ;;
        "N")
            echo "$LINE" >> $trashlog
        ;;
        *)
        :
        ;;
    esac
done
