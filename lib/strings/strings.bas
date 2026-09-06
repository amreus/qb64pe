$includeonce


' Whitespace:  0, 9, 10, 11, 12, 13, 32

Function IsSpace (c As String)
    If Len(c) = 0 Then Exit Function
    Dim As Integer code
    code = Asc(c)
    Select Case code
        Case 0, 9, 10, 11, 12, 13, 32
            IsSpace = _TRUE
    End Select
End Function

Function TrimLeft$ (s As String)
    While IsSpace(Left$(s, 1)) _AndAlso Len(s) > 1
        s = Mid$(s, 2)
    Wend
    TrimLeft$ = s
End Function

Function TrimRight$ (s As String)
    While IsSpace(Right$(s, 1))
        s = Left$(s, Len(s) - 1)
    Wend
    TrimRight$ = s
End Function

Function Trim$ (s As String)
    Trim$ = TrimRight$(TrimLeft$(s))
End Function


