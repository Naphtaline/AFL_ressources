#!/usr/bin/awk -f
BEGIN {
  line_count = 0;
}

/.*/ {
  if (line_count >= 2) {
    $1=""
    print $0 ""
  }
  if (line_count > limit) {
    print "\n"
    exit 0
  }
  if (line_count > 0) {
    line_count++
  }
}

/^==[0-9]+== Process terminating/ {
  $1=""
  print "         ___________________"
  print "________/ crash case " id " \\________\n"

  print $0 
  line_count++
}

