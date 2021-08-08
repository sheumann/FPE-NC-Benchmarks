FPE/NC Benchmarks
=================

This repository has implementations of some simple benchmarks for the
Floating Point Engine (FPE), Number Cruncher, or NumberCruncher Reloaded
floating point cards on the Apple IIGS.  They are written in ORCA/M
assembly and use macros to directly access the card.

Currently, this includes the Float and Savage benchmarks.  These are
simple benchmarks that were used in some old Byte magazine articles.
There are also versions of these benchmarks included with ORCA/C,
ORCA/Pascal, and ORCA/Modula-2 (all of which use SANE for floating-point
computations), so you can compare the performance against those.
Note that the stock ORCA versions use reduced iteration counts compared
to the original Byte benchmarks (probably to give reasonable execution
times using SANE), but these FPE/NC versions use the full iteration counts.

This code uses somewhat modified versions of the FPE macros and equates
for ORCA/M, which are included in the repository.  These may be useful in
other projects.
