.PHONY:main
.PHONY:test
.PHONY:clean

LIB_AHVEN="-aPlib/ahven/lib/gnat"

main:
	gprbuild gnat/skill.gpr

build_tests:
	gprbuild $(LIB_AHVEN) gnat/skill_tests.gpr

check: build_tests
	./tester -c

clean:
	gprclean $(LIB_AHVEN) gnat/skill_tests.gpr
