
BEGIN {
  line_count= 0;
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

/^==[0-9]+== Invalid.*/ {
  if (line_count > 0)
    exit 0
  $1=""
  print "         ___________________"
  print "________/ crash case " id " \\________\n"

  print $0 
  line_count++
}

/^==[0-9]+== Conditionnal.*/ {
  if (line_count > 0)
    exit 0
  $1=""
  print "         ___________________"
  print "________/ crash case " id " \\________\n"

  print $0
  line_count++
}

/^==[0-9]+== Syscall.*/{
  if (line_count > 0)
    exit 0
  $1=""
  print "         ___________________"
  print "________/ crash case " id " \\________\n"

  print $0
  line_count++
}

/^==[0-9]+== Mismatched.*/{
  if (line_count > 0)
    exit 0
  $1=""
  print "         ___________________"
  print "________/ crash case " id " \\________\n"

  print $0
  line_count++
}
