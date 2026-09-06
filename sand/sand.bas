$Console
Screen _NewImage(801, 401, 256)
Randomize Timer

Dim Shared As Integer rows, cols
Dim Shared w: w = 5
cols = _Width \ w
rows = _Height \ w

Dim Shared grid(cols, rows) As Integer

Do
    tick = tick + 1
    _Limit 60
    Cls
    grid(cols \ 4 + Rnd * cols \ 2, 1) = 7
    count = count + 1
    Locate 1, 1: Print "blocks:", count
    drawGrid
    _Display
    updateGrid
Loop Until InKey$ <> ""

System


Sub grid.set (x As Integer, y As Integer, c)
    grid(x, y) = c
End Sub

Sub drawGrid
    For y = 0 To rows
        For x = 0 To cols
            If grid(x, y) Then
                drawCell x, y
            End If
        Next
    Next
End Sub

Sub updateGrid
    For r = rows - 2 To 0 Step -1
        For c = 0 To cols - 1
            checkSwap c, r
        Next
    Next
End Sub

Sub checkSwap (i As Integer, r As Integer)
    'On Error GoTo swapHandler
    '_echo _tostr$(i) +", "+ _tostr$(r)
    If grid(i, r) <> 0 _AndAlso i < cols _AndAlso i > 1 Then
        below = grid(i, r + 1)
        belowLeft = grid(i - 1, r + 1)
        belowRight = grid(i + 1, r + 1)
        If below = 0 Then
            Swap grid(i, r), grid(i, r + 1)
        ElseIf belowLeft = 0 _AndAlso belowRight = 0 Then
            If Rnd < 0.5 Then
                Swap grid(i, r), grid(i - 1, r + 1)
            Else
                Swap grid(i, r), grid(i + 1, r + 1)
            End If
        ElseIf i > 0 _AndAlso belowLeft = 0 Then
            Swap grid(i, r), grid(i - 1, r + 1)
        ElseIf i < cols _AndAlso belowRight = 0 Then
            Swap grid(i, r), grid(i + 1, r + 1)
        End If
    End If
End Sub


Sub drawCell (x As Single, y As Single)
    Line (x * w + 1, y * w + 1)-(x * w + w - 1, y * w + w - 1), grid(x, y), BF
End Sub

