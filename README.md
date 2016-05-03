# American Fuzzy Lop - presentation & quick start guide
======================================================

Here you'll find a presentation / quick-start-guide to use AFL, or just to think in which way you could this kind of software test program.

I hope you'll enjoy it !

[![pres image](/pres.png?raw=true)](/AFL_GITHUB.pdf)

Download it [here](/AFL_GITHUB.pdf?raw=true)

I will also add some usefull scripts, which gravitate around afl.

For the moment, there is only two scripts : 
  - **crash_summary.sh** which which count for each out signals the number of associated crashes. 
  - **parse_callstack.sh** (go with **parse_valgrind.awk**) will replay all your crash cases with valgrind, and will gather all crash call stacks in one output.
