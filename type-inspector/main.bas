Option _Explicit
$Console:Only

Dim As Integer in_type
Dim f As Long
Dim As String infile, lin, typeName, var_name, q

q = Chr$(34)
'if _commandcount <> 2 then
'   print "usage: "+command$(0)+" sourcefile outfile"
'   system
'end if


'infile = Command$(1)
infile = _StartDir$ + "/" + Command$(1)
'outfile = Command$(1)
'if _commandcount < 1 or not _fileexists(infile) then
'   print
'   print "Usage:"
'   print spc(4) + command$(0) + " sourcefile"
'   print
'   system
'end if

f = FreeFile

Open infile For Input As #f

While Not EOF(f)

    Line Input #f, lin
    lin = _Trim$(lin)

    If in_type = 0 And UCase$(Left$(lin, 5)) = "TYPE " Then
        typeName = Mid$(lin, 6)
        Print "Sub inspect_" + typeName + " (T as " + typeName + ")"
        Print "     print " + q + typeName + ":" + q
        in_type = _TRUE
        _Continue
    End If

    If in_type And UCase$(lin) = "END TYPE" Then
        in_type = _FALSE
        Print "End Sub"
        Print
    End If

    If in_type Then
        var_name = Left$(lin, InStr(lin, " ") - 1)
        Print " ";
        Print "    print " + q + "    ." + var_name + " = " + q + " + ";
        typeName = LCase$(Mid$(lin, _InStrRev(lin, " ") + 1))
        If typeName = "string" Then
            Print "T." + var_name
        Else
            Print "_tostr$(T." + var_name + ")"
        End If
    End If
Wend

Close #f
System

Function is_type_start (lin As String, nam As String)
    Dim ret
    If InStr(LCase$(lin), "type") = 1 Then
        ret = -1
        nam = Mid$(lin, InStr(lin, " ") + 1)
    End If
    is_type_start = ret
End Function

Function is_type_end (lin As String)
    Dim ret
    If LCase$(_Trim$(lin)) = "end type" Then
        ret = -1
    End If
    is_type_end = ret
End Function


