#!/usr/bin/env awk -f
BEGIN {
  line_count = 0;
  temp = "";
  offseted_limit = limit + 3;
}

/.*/ {
  if (line_count > 0 && line_count < offseted_limit) 
  {
    if ($0 != "")
      temp = temp"\n"$0
    line_count++;
  }
  if (line_count == offseted_limit)
  {
    if (tab[temp] == "")
      tab[temp] = 1;
    else
      tab[temp]++;
    line_count = 0;
    temp = ""
  }
}

/^________\/ crash case.*/  {
  line_count++
}

END {
  print "           __________________________"
  print "**********/ Compiled valgrind result \\**********\n\n"
  val = 1;
  for (i in tab)
  {
    print "********/ Stack " val " happend " tab[i] " time(s)\\********"
    print i "\n\n\n"
    val++
  }
}
