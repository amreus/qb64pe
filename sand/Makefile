EXE=sand
SRC=sand.bas

$(EXE): $(SRC)
	qb64pe -w -x $^ -o $@

.PHONY: fmt clean init

fmt:
	qb64pe -y $(SRC) -o $(SRC)

clean:
	$(RM) $(EXE)

init:
	touch $(SRC)
