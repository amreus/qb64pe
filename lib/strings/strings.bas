$IncludeOnce

' Whitespace:  0, 9, 10, 11, 12, 13, 32

Function IsWhiteSpace (c As String)
    If Len(c) = 0 Then Exit Function
    Dim As Integer code
    code = Asc(c)
    Select Case code
        Case 0, 9, 10, 11, 12, 13, 32
            IsWhiteSpace = _TRUE
    End Select
End Function

Function TrimLeft$ (s As String)
    While IsWhiteSpace(Left$(s, 1))
        If Len(s) > 1 Then
            s = Mid$(s, 2)
        Else
            s = ""
        End If
    Wend
    TrimLeft$ = s
End Function

Function TrimRight$ (s As String)
    While IsWhiteSpace(Right$(s, 1))
        s = Left$(s, Len(s) - 1)
    Wend
    TrimRight$ = s
End Function

Function Trim$ (s As String)
    Trim$ = TrimRight$(TrimLeft$(s))
End Function

