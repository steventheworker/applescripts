if [ -z "$1" ]
then
    echo "No argument supplied"
    exit 1
fi
arg1=$1

# $prefix/$fileName.m3u8
IFS=/ read -a myarray <<< "$arg1"

fileName=${myarray[*]: -1}
endIndex="$(( ${#arg1} - ${#fileName} - 1))"
prefix="${arg1:0:$(($endIndex))}"

IFS=? read -a filePathAndQuery <<< "$fileName"

i=0
while read line; do
	((i++))
	if [[ $(($i)) -lt '6' ]]; then continue; fi	
	if [[ $(($i % 2)) != '0' ]]; then
    		continue
  	fi
	echo $line
	if [[ $line == http* ]]; then
		open $line
        	# wget $line
	else
		open "$prefix/$line"
                # wget "$prefix/$line"
        fi
done < ~/Downloads/${filePathAndQuery[0]}
