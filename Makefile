.PHONY:main
.PHONY:test
.PHONY:clean

LIB_AHVEN="-aPlib/ahven/lib/gnat"

main:
	gprbuild gnat/skill.gpr

build_tests:
	gprbuild $(LIB_AHVEN) gnat/skill_tests.gpr

check: clean build_tests
	./tester

clean:
	gprclean gnat/skill.gpr
	gprclean $(LIB_AHVEN) gnat/skill_tests.gpr
