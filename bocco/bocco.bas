
' <h2>Bocco</h2> is <a href="https://ashkenas.com/docco/">Docco</a> written in QB64pe for QB64pe.

Option _Explicit
$Console:Only

$Embed:'./res/template.html','template'

'$Include:'/home/jim/code/qb64pe/qb64pe-repo/lib/strings/cut.bas'


' Top level Types and Variables.

Type SectionType
    docs As String
    code As String
End Type

Dim Shared Sections(32767) As SectionType
Dim Shared SectionSize As Integer

Dim As String ln, first, rest, docsText, codeText
Dim As Integer ok, hasCode

Const DELIM = Chr$(39) + Chr$(32)

' Open the source code file given on the command line.
Dim f As Long: f = FreeFile
Open _StartDir$ + Command$(1) For Input As #f

' Main Section
' Parse the file into an Array of SectionType.
While Not EOF(f)
    Line Input #f, ln
    'ln = _Trim$(ln)
    ok = Cut(ln, DELIM, first, rest)
    'If Left$(ltrim$(ln), 2) = DELIM Then
    If ok Then
        If hasCode Then
            Save Sections(), docsText, codeText
            hasCode = _FALSE
            docsText = ""
            codeText = ""
        End If
        docsText = docsText + "<p>" + rest + "</p>" + Chr$(10)
    Else
        hasCode = _TRUE
        codeText = codeText + ln + Chr$(10)
    End If
Wend
Save Sections(), docsText, codeText

' Close the file, print the html, and exit the program.
Close #f

OutputHTML2

System

' <h3>Procedures</h3>

' Save appends the doc and code textsto the Sections array.
Sub Save (sec_list() As SectionType, docs As String, code As String)
    If Len(docs) = 0 _AndAlso Len(code) = 0 Then
        Exit Sub
    End If
    sec_list(SectionSize).docs = docs
    sec_list(SectionSize).code = Escape$(code)
    SectionSize = SectionSize + 1
End Sub

' todo: need to escape more than <
Function Escape$ (str_html As String)
    Dim As Integer i
    Dim As String s, first, rest
    s = str_html
    Escape$ = str_html
    Do
        i = InStr(1, s, "<")
        If i > 0 Then
            first = Left$(s, i - 1)
            rest = Mid$(s, i + 1)
            s = first + "&lt;" + rest
            'Print "s:", s
        End If
    Loop While i > 0
    Escape$ = s
End Function

' Vertical layout (docco classic)
Sub OutputHTML
    Dim As Integer i
    PrintHeader
    For i = 0 To SectionSize
        Print "<div id=" + Chr$(34) + "section-" + _ToStr$(i) + Chr$(34) + ">"
        Print Sections(i).docs
        Print "<pre>"
        Print Sections(i).code
        Print "</pre>"
        Print "<br>"
        Print "</div>"
    Next
    PrintTrailer
End Sub

' Horizontal layout (docco parallel)
Sub OutputHTML2
    Dim As Integer i
    PrintHeader
    Print "<table>"
    For i = 0 To SectionSize
        Print "<tr id=" + Chr$(34) + "section-" + _ToStr$(i) + Chr$(34) + ">"
        Print "<td class=" + Chr$(34) + "docs" + Chr$(34) + ">" + Sections(i).docs + "</td>"
        Print "<td class=" + Chr$(34) + "code" + Chr$(34) + "><pre>" + Sections(i).code + "</pre></td>"
        Print "</tr>"
    Next
    Print "</table>"
    PrintTrailer
End Sub

' <tt>PrintHeader</tt> splits the template in 2 printing the first part.
' The header is retained after the procedure exits.

Sub PrintHeader
    Static called As Integer
    Static header As String
    Dim As Integer ok
    Dim As String t, trailer
    If Not called Then
        t = _Embedded$("template")
        ok = Cut(t, "CONTENT", header, trailer)
        called = _TRUE
    End If
    Print header
End Sub

Sub PrintTrailer
    Static called As Integer
    Static trailer As String
    Dim As Integer ok
    Dim As String t, header
    If Not called Then
        t = _Embedded$("template")
        ok = Cut(t, "CONTENT", header, trailer)
        called = _TRUE
    End If
    Print trailer
End Sub

