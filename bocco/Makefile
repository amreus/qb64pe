bocco: bocco.bas res/template.html
	qb64pe -w -x $< -o $@

.PHONY: fmt clean run

run: bocco
	./bocco bocco.bas > bocco.html

fmt:
	qb64pe -w -y bocco.bas -o bocco.bas

clean:
	$(RM) bocco
