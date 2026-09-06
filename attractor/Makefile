EXE=main
SRC=ball.bas

$(EXE): $(SRC) vector.bas
	qb64pe -w -x $^ -o $@

.PHONY: fmt clean

fmt:
	qb64pe -y $(SRC) -o $(SRC)
	qb64pe -y vector.bas -o vector.bas

clean:
	$(RM) $(EXE)
