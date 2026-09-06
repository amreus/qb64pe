$IncludeOnce

Function Cut (s As String, sep As String, before As String, after As String)

    ''' Cuts String s in 2 pieces at the first occurance of sep.
    ''' Returns _TRUE if separator appears in s, else _FALSE.
    ''' The separator is not part of the result strings.

    Dim As Integer index
    index = InStr(1, s, sep)
    If index > 0 Then
        before = Left$(s, index - 1)
        after = Mid$(s, index + Len(sep))
        Cut = _TRUE
    Else
        before = s
	after = ""
        Cut = _FALSE
    End If
End Function
