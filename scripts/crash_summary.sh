#set -xeu

total=0
sig6=0
sig8=0
sig11=0
val=""
location=""

if [ $# -eq "0" ] ; then
    location=`ls`
else
    location=`ls $1`
fi

for i in $location ; do
  val=$(echo "$i" | sed 's/id:[0-9][0-9]*,sig:\([0-9][0-9]*\).*/\1/')
  
  if [[ $val = "06" ]]
    then
      ((sig6++))
      ((total++))    
  elif [[ $val = "08" ]]
    then                  
      ((sig8++))       
      ((total++))       
  elif [[ $val = "11" ]]
    then                  
      ((sig11++))       
      ((total++))       
    fi
done


echo "Total crashes found  : $total"
echo "------------------------------"

if [[ $total = '0' ]]
  then
    echo "Please give crashes folder path as parameter 1."
    echo ""
    echo "Default beahavior : research in the curent folder."
    exit
  fi

echo "[+] Crashes whith sig 11 : $sig11"
echo "[+] Crashes whith sig 8  : $sig8"
echo "[+] Crashes whith sig 6  : $sig6"
