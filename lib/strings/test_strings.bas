Option _Explicit
$Console:Only
$Asserts:Console

'$Include:'../strings.bas'

Const CR = Chr$(13)
Const LF = Chr$(10)
Const CRLF = CR + LF
Const TB = Chr$(9)

' TrimLeft$

Dim As String test_str, tmp_str

test_str = "  " ' 2 spaces
_Assert TrimLeft$(test_str) = "", "TrimLeft$"

test_str = "  Hello  " ' 2 spaces
_Assert TrimLeft$(test_str) = "Hello  "
_Assert test_str = "Hello  "

test_str = Chr$(0) + Chr$(9) + Chr$(10) + Chr$(11) + Chr$(12) + Chr$(13) + Chr$(32)
_Assert TrimLeft$(test_str) = ""

test_str = Chr$(0) + Chr$(9) + Chr$(10) + Chr$(11) + Chr$(12) + Chr$(13) + Chr$(32) + "Hello"
tmp_str = TrimLeft$(test_str)
_Assert test_str = "Hello"
_Assert tmp_str = test_str

' TrimRight$
test_str = " "
_Assert TrimRight$(" ") = ""
_Assert TrimRight$("  ") = ""
_Assert TrimRight$("Hi  " + Chr$(9)) = "Hi"

' Trim$

_Assert Trim$(" ") = ""
_Assert Trim$("  ") = ""
_Assert Trim$("   " + Chr$(10) + "  ") = ""
_Assert Trim$(" Hi ") = "Hi"

' Cut
Dim As Integer res
Dim As String first, rest
test_str = "To be, or not to be"
res = Cut(test_str, ",", first, rest)
_Assert res = _TRUE
_Assert test_str = "To be, or not to be"
_Assert first = "To be"
_Assert rest = " or not to be"

res = Cut(first, " ", first, rest)
_Assert res = _TRUE
_Assert first = "To"
_Assert rest = "be"

test_str = "Header: Value" + CRLF
res = Cut(test_str, ": ", first, rest)
_Assert res
_Assert first = "Header"
_Assert rest = "Value" + CRLF
_Assert Trim$(rest) = "Value"

Print
Print "✅ ";
Print "If you made it here, then there were no failed tests."
Print

System

