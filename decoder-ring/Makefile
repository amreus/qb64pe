EXE=cry
SRC=cry.bas

$(EXE): $(SRC)
	qb64pe -w -x $^ -o $@

.PHONY: fmt clean

fmt:
	qb64pe -y $(SRC) -o $(SRC)

clean:
	$(RM) $(EXE)
