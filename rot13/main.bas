$Console:Only
Option _Explicit

Dim As String filename
Dim As Long f
Dim As String c
Dim As Integer n

filename = Command$(1)
f = FreeFile

Open filename For Input As #f

While Not EOF(f)
    c = Input$(1, f)
    n = Asc(c)
    If n >= 65 _AndAlso n <= 90 Then
        n = n + 13
        If n > 90 Then n = n - 26
    End If
    If n >= 97 _AndAlso n <= 122 Then
        n = n + 13
        If n > 122 Then n = n - 26
    End If
    Print Chr$(n);
Wend

Close #f

System
