# American Fuzzy Lop - presentation & quick start guide
======================================================

Here you'll find a presentation / quick-start-guide to use AFL, or just to think in which way you could this kind of software test program.

I hope you'll enjoy it !

[![pres image](/pres.png?raw=true)](/AFL_GITHUB.pdf)

Download it [here](/AFL_GITHUB.pdf?raw=true)

I will also add some usefull scripts, which gravitate around afl.

For the moment, there is only two scripts : 
  - **crash_summary.sh** which which count for each out signals the number of associated crashes. 
  - **parse_callstack.sh** will replay all your crash cases with valgrind, and will gather all crash valgrind logs in two outputs, one with **first memory error call stack**, and one with the **crash call stack**.
    - subscript **parse_valgrind_mem_error.awk** and **parse_valgrind_process_term.awk** are required
