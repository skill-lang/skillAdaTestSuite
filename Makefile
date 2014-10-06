.PHONY:main
.PHONY:test
.PHONY:clean

LIB_AHVEN="-aPlib/ahven/lib/gnat"

main:
	gprbuild gnat/skill.gpr

build_tests:
	gprbuild $(LIB_AHVEN) gnat/skill_tests.gpr

build_benchmark:
	gprbuild gnat/skill_benchmark.gpr

benchmark: build_benchmark

check: build_tests
	mkdir -p results && ./tester -x -d results

clean:
	gprclean $(LIB_AHVEN) gnat/skill_tests.gpr
