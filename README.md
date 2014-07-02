README
======

skill-ada

# Ahven: test suite
1) remove lib/ahven, if it exists
2) Download ahven into this directory, unpack it and change to the extracted folder.
   Then build ahven with `make PREFIX=../lib/ahven build_lib install_lib`

# Run tests
make check

# Run benchmarks
make benchmark && ./bench

# Run main
make && ./start

# Clean
make clean

# gprof
gnatmake -pg -P gnat/skill.gpr
./main
 gprof main gmon.out > analysis.txt
