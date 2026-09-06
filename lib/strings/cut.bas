$IncludeOnce

Function Cut (s As String, sep As String, before As String, after As String)

    ''' Cuts String s in 2 pieces at the first occurance of sep.
    ''' Returns _TRUE if separator appears in s, else _FALSE.
    ''' The separator is not part of the result strings.

    Dim As String tstr
    tstr = s
    Dim As Integer index
    index = InStr(1, tstr, sep)
    If index > 0 Then
        before = Left$(tstr, index - 1)
        after = Mid$(tstr, index + Len(sep))
        Cut = _TRUE
    Else
        before = tstr
        after = ""
        Cut = _FALSE
    End If
End Function
