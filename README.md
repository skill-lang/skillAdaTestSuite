README
======

skill-ada

# Ahven: test suite
Download ahven into this directory, unpack it and change to the extracted folder. Then build ahven with `make PREFIX=../lib/ahven build_lib install_lib`

# GNATcoll
./configure --prefix=/usr/local/gnatcoll --without-python --disable-gtk --without-postgresql --without-sqlite

# gprof
gnatmake -pg -P gnat/skill.gpr
./main
 gprof main gmon.out > analysis-date-20.txt

