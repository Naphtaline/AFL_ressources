#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Usage :"
    echo "./parse_callstack.sh \"command\" [crash_dir] [nb_lines]"
    echo ""
    echo "command   : is mandatory. It should be the same command as you gave to afl-fuzz"
    echo "            Crash cases will be put where you wrote @@."
    echo "crash_dir : is optional. If you don't give anything, default crash folder will be ./ ."
    echo "nb_lines  : is optional. Give the number of line you want from each crash callstack. Default value is 5."
    echo "            You MUST specify crash_dir if you want to change this options."
    echo ""
    echo "example : ./parse_callstack.sh \"/home/john/myBin loadFile @@ myFormat\" /home/john/crash_dir/ 15"
    echo ""
    echo "You can find the result in the file \"valgrind_result\", beside this script."
    exit 1
fi

if [ $# -eq "1" ] ; then
  location=`ls`
  base_location=`pwd`
else
  location=`ls $2`
  base_location=$2
fi

if [ $# -eq "3" ] ; then
  nb_lines=$3
else
  nb_lines=5
fi

check_var=`which valgrind`

if [[ $check_var == "" ]] ; then
  echo ""
  echo "[*] ERROR : Unable to find valgrind."
  exit 1
fi

check_var=`ls parse_valgrind.awk`

if [[ $check_var == "" ]] ; then
  echo ""
  echo "[*] ERROR : Unable to find parse_valgrind.awk."
  echo "[*]         Please, put it beside this script."
  exit 1
fi

check_var=`ls parse_result.awk`

if [[ $check_var == "" ]] ; then
  echo ""
  echo "[*] ERROR : Unable to find parse_result.awk."
  echo "[*]         Please, put it beside this script."
  exit 1
fi

nothig ()
{
  echo ""
}

trap nothing SIGSEGV SIGABRT SIGILL SIGFPE

id=""
count=0;
current=0;

for i in $location; do
  val=$(echo "$i" | sed 's/id:[0-9][0-9]*,sig:\([0-9][0-9]*\).*/\1/')

  if [[ $val = "11" ]] ||  [[ $val = "06" ]] ||  [[ $val = "08" ]] ; then
    count=$((count+1))
  fi
done

printf "\nIt might take a long moment...\n"

rm raw_valgrind_result

for i in $location ; do
  val=$(echo "$i" | sed 's/id:[0-9][0-9]*,sig:\([0-9][0-9]*\).*/\1/')
  
  if [[ $val = "11" ]] ||  [[ $val = "06" ]] ||  [[ $val = "08" ]] ; then
    
    current=$((current+1))
    echo "[*] " $current "/" $count
    
    file_path=$base_location$i
    
    cmd=${1/@@/$file_path}
    valgrind $cmd > crash_case 2>&1
    id=$(echo "$i" | sed 's/id:\([0-9][0-9]*\).*/\1/')
    awk -f parse_valgrind.awk -v id="$id" limit="$nb_lines" ./crash_case >> raw_valgrind_result
  fi
done

rm crash_case

awk -f parse_result.awk -v limit="$nb_lines" ./raw_valgrind_result > compiled_valgrind_result
