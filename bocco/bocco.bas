'' Bocco is <a href="https://ashkenas.com/docco/">Docco</a> written in QB64pe for QB64pe.


Option _Explicit
$Console:Only

$Embed:'./res/head.html','template'

'$Include:'/home/jim/code/qb64pe/qb64pe-repo/lib/strings/cut.bas'

'' A Comment.

Type SectionType
    docs As String
    code As String
End Type

Type SectionList
    size As Integer
    sections(1000) As SectionType
End Type


Dim f As Long: f = FreeFile
Dim As String ln, first, rest, docsText, codeText
Dim As Integer idx, ok, i, hasCode

Dim code(1000) As String
Dim comments(1000) As String
'Dim EmptySection As SectionType
Dim Shared Sections As SectionList

'' Open the file.
Open Command$(1) For Input As #f

'' While there are more lines to read..
While Not EOF(f)
    Line Input #f, ln
    ok = Cut(ln, "''", first, rest)
    'first = LTrim$(first)
    'print first
    'If ok _AndAlso Mid$(first, 1) = "'" Then
    If Left$(ln, 2) = "''" Then
        'comments(idx) = rest
        If hasCode Then
            Save Sections, docsText, codeText
            hasCode = _FALSE
            docsText = ""
            codeText = ""
        End If
        docsText = docsText + rest + Chr$(10)
    Else
        'code(idx) = ln
        hasCode = _TRUE
        codeText = codeText + ln + Chr$(10)
    End If
    'idx = idx + 1
Wend
Save Sections, docsText, codeText

Close #f

'' Split the html template into header and tail
Dim As String t, header, trailer
t = _Embedded$("template")
ok = Cut(t, "CONTENT", header, trailer)


'' Output the html

'' todo: Sections.sections is kind of awkward.

Print header
For i = 0 To Sections.size
    Print Sections.sections(i).docs
    Print "<pre>"
    Print Sections.sections(i).code
    Print "</pre>"
    Print "<br>"
Next
Print trailer

'' Exit program
System


'' The rest is unused code

'Print _Embedded$("header")
Print "<div id=container>"
Print "<div id=background></div>"
Print "<table>"
For i = 0 To Sections.size
    Print "<tr id=" + Chr$(34) + "section-" + _ToStr$(i) + Chr$(34) + ">"
    Print "<td class=" + Chr$(34) + "docs" + Chr$(34) + ">" + Sections.sections(i).docs + "</td>"
    Print "<td class=" + Chr$(34) + "code" + Chr$(34) + ">" + Sections.sections(i).code + "</td>"
    Print "</tr>"
Next
Print "</table>"
Print "</div>"
Print "</body></html>"

System

f = FreeFile

Open "bocco.html" For Output As #f
'Print #f, _Embedded$("header")
Print #f, "<table>"
For i = 0 To idx
    Print #f, "<tr><td>", comments(i), "</td><td><pre>", Escape$(code(i)), "</pre></td></tr>"
Next
Print #f, "</table>"
Close #f


'' todo: need to escape more than <
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

Sub Save (sec_list As SectionList, docs As String, code As String)
    'Print "saving.."
    'Print "docs:", docs
    'Print "code:", code
    'Print
    sec_list.sections(sec_list.size).docs = docs
    sec_list.sections(sec_list.size).code = Escape$(code)
    sec_list.size = sec_list.size + 1
End Sub
