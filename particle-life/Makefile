SRC=main.bas

EXE=main

$(EXE): $(SRC)
	qb64pe -w -x $^ -o $@


.PHONY: fmt clean init run

fmt:
	qb64pe -y $(SRC) -o $(SRC)

clean:
	$(RM) $(EXE)

run: $(EXE)
	./$(EXE)

init:
	touch $(SRC)
