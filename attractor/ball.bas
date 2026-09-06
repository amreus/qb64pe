Option _Explicit
$Console
_Console On
'_FullScreen

_Title "Attractor"

Randomize Timer

Const FRICTION = 1
Dim Shared N: N = 10
Dim Shared Balls(1 To N) As BallType
Dim Shared Bounce As Single: Bounce = 1

Main

'$Include:'vector.bas'

Type BallType
    position As Vector
    velocity As Vector
    acceleration As Vector
    radius As Integer
    color As Integer
End Type


Sub Main

    Dim As Integer mx, my, i
    Dim k$
    Dim att As BallType
    Screen _NewImage(1024, 768, 256)
    vector_set att.position, _Width \ 2, _Height \ 2
    Initialize Balls()

    Do
        _Limit 60
        Cls
        Do While _MouseInput
            If _MouseButton(1) Then
                mx = _MouseX
                my = _MouseY
                If mx > 0 _AndAlso my > 0 Then
                    att.position.x = mx
                    att.position.y = my
                End If
            End If
        Loop
        Locate 1, 2: Print "Click to set attractor, r to restart"
        For i = 1 To N
            Update i, att.position.x, att.position.y
            checkBounds i
            drawBall Balls(i)
        Next
        connect
        Circle (att.position.x, att.position.y), 10, 2
        _Display
        k$ = InKey$
        If k$ = "r" Then Run
    Loop Until k$ = Chr$(27)

    System

End Sub

Sub Initialize (Balls() As BallType)
    Dim As Integer i
    For i = 1 To N
        Balls(i).radius = 10
        randomSingle Balls(i).position.x, Balls(i).radius, _Width - Balls(i).radius
        randomSingle Balls(i).position.y, Balls(i).radius, _Height - Balls(i).radius
        randomVector Balls(i).velocity, -1, 1
        Balls(i).color = 15 '_HSB32(360*rnd, 100, 100)
    Next
End Sub

Sub drawBall (Ball As BallType)
    Circle (Ball.position.x, Ball.position.y), Ball.radius, Ball.color
End Sub

Sub Update (i As Integer, x As Integer, y As Integer) '(Ball As BallType)
    Dim dir As Vector
    vector_set dir, x, y
    vector_sub dir, Balls(i).position
    vector_normalize dir
    vector_mul dir, 0.3
    vector_copy Balls(i).acceleration, dir
    vector_add Balls(i).velocity, Balls(i).acceleration
    vector_limit Balls(i).velocity, 10
    vector_add Balls(i).position, Balls(i).velocity
    vector_set Balls(i).acceleration, 0, 0
    'vector_mul Balls(i).velocity, FRICTION
    'Balls(i).colr = _HSB32(Rnd * 360, 50, 100)
End Sub

Sub connect
    Dim As Integer i, j
    For i = 1 To N
        For j = 1 To N
            If i = j Then _Continue
            If ((vector_dist(Balls(i).position, Balls(j).position)) < 100) Then
                Line (Balls(i).position.x, Balls(i).position.y)-(Balls(j).position.x, Balls(j).position.y), 8
            End If

        Next
    Next

End Sub


Sub checkBounds (ball As Integer)
    If Balls(ball).position.x - Balls(ball).radius <= 0 Then
        Balls(ball).velocity.x = Balls(ball).velocity.x * -Bounce
    End If
    If Balls(ball).position.x + Balls(ball).radius >= _Width Then
        Balls(ball).velocity.x = Balls(ball).velocity.x * -Bounce
    End If
    If Balls(ball).position.y - Balls(ball).radius <= 0 Then
        Balls(ball).velocity.y = Balls(ball).velocity.y * -Bounce
    End If
    If Balls(ball).position.y + Balls(ball).radius >= _Height Then
        Balls(ball).velocity.y = Balls(ball).velocity.y * -Bounce
    End If
    If Balls(ball).position.y > _Height - Balls(ball).radius Then Balls(ball).position.y = _Height - Balls(ball).radius
End Sub

Sub randomSingle (r As Single, min As Single, max As Single)
    r = Rnd * (max - min) + min
End Sub

Sub randomInt (r As Integer, min As Integer, max As Integer)
    r = Rnd * (max - min) + min
End Sub

Sub randomVector (v As Vector, min, max As Single)
    randomSingle v.x, min, max
    randomSingle v.y, min, max
End Sub

