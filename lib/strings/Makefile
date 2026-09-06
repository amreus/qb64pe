TEST_SRC := test_strings.bas
SOURCES := $(wildcard *.bas)
DEPS := $(filter-out $(TEST_SRC),$(SOURCES))


test_strings: test_strings.bas $(DEPS)
	qb64pe -w -x $< -o $@

