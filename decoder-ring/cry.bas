$Console:Only

file$ = _StartDir$ + Command$(1)
contents$ = _ReadFile$(file$)

k = 31

For i = 1 To Len(contents$)
    Print Chr$(Asc(contents$, i) Xor k);
Next
Print
System
