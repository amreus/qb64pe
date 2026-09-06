$Console
Randomize Timer
Screen _NewImage(1024, 800, 32)

'$Include:'../lib/vector.bi'

Type ParticleType
    id As Integer
    r As _Float
    pos As Vector
    vel As Vector
    type As Integer
    color As _Unsigned Long
End Type


Dim Shared As Integer numTypes, colorStep, numParticles
Dim Shared As _Float K, Friction


numTypes = 6
Dim Shared As _Float forces(numTypes, numTypes), minDistances(numTypes, numTypes), radii(numTypes, numTypes)
numParticles = numTypes * 100' \ numTypes
Dim Shared As ParticleType Swarm(numParticles)
colorStep = 360 \ numTypes
K = 0.05
Friction = 0.85

SetUp

MainLoop:
Do
    _Limit 60
    Cls
    For i = 0 To numParticles - 1
        particle_update Swarm(i)
        particle_display Swarm(i)
    Next
    _Display
    k$ = InKey$
    'If k$ = "r" Then SetUp
    If k$ = "r" Then setParameters
Loop Until k$ = Chr$(27) Or k$ = "q"
  
System

Sub SetUp
    Dim p As ParticleType
    For i = 0 To numParticles - 1
        p.id = i
        p.r = 5
        p.pos.x = random_range(10, _Width - 10)
        p.pos.y = random_range(10, _Height - 10)
        p.type = (i Mod numTypes)
        'cprint _tostr$(p.type)
        p.color = _HSB32(p.type * colorStep , 100, 100)
        'cprint _tostr$(p.color)
        Swarm(i) = p
    Next
    setParameters
End Sub

Sub setParameters
    For i = 0 To numTypes - 1
        For j = 0 To numTypes - 1
            forces(i, j) = random_range(0.3, 1)
            If Rnd < 0.5 Then
                forces(i, j) = random_range(-0.3, -1)
            End If
            '_echo _tostr$(forces(i, j))
            minDistances(i, j) = random_range(30, 50)
            _Echo _ToStr$(minDistances(i, j))
            radii(i, j) = random_range(70, 250)
            '_echo _tostr$(radii(i, j))
        Next
    Next
    Swarm(0).pos.x = _Width / 2
    Swarm(0).pos.y = _Height / 2
End Sub

Sub particle_update (p As ParticleType)
    Dim As ParticleType p2
    Dim As Vector direction, totalForce, acceleration, force
    Dim As _Float dis
    For i = 0 To numParticles - 1
        If i <> p.id Then
            p2 = Swarm(i)
            vector_sub3 p.pos, p2.pos, direction
            If direction.x > 0.5 * _Width Then
                direction.x = direction.x - _Width
            End If
            If direction.x < -0.5 * _Width Then
                direction.x = direction.x + _Width
            End If
            If direction.y > 0.5 * _Height Then
                direction.y = direction.y - _Height
            End If
            If direction.y < -0.5 * _Height Then
                direction.y = direction.y + _Height
            End If
            dis = vector_mag(direction)
            vector_normalize direction
            If dis < minDistances(p.type, p2.type) Then
                vector_copy force, direction
                vector_mul force, Abs(forces(p.type, p2.type) * -3)
                vector_mul force, map(dis, 0, minDistances(p.type, p2.type), 1, 0)
                vector_mul force, K
                vector_add totalForce, force
                'If p.id = 0 Then
                '    Line (p.pos.x, p.pos.y)-(p2.pos.x, p2.pos.y)
                'End If
            End If
            If dis < radii(p.type, p2.type) Then
                vector_copy force, direction
                vector_mul force, forces(p.type, p2.type)
                vector_mul force, map(dis, 0, radii(p.type, p2.type), 1, 0)
                vector_mul force, K
                vector_add totalForce, force
                'If p.id = 0 Then
                '    Line (p.pos.x, p.pos.y)-(p2.pos.x, p2.pos.y), _hsb32(0, 50, 50)
                'End If
            End If
        End If
    Next
    vector_copy force, totalForce
    vector_mul force, 100
    'if p.id = 0 then
    'line (p.pos.x, p.pos.y)-step(force.x, force.y), _HSB32(p.type * colorStep + 30, 100, 100)
    'end if
    vector_add acceleration, totalForce
    vector_add p.vel, acceleration
    vector_add p.pos, p.vel
    wrap p.pos.x, 0, _Width
    wrap p.pos.y, 0, _Height
    vector_mul p.vel, Friction
End Sub

Sub particle_display (p As ParticleType)
    Circle (p.pos.x, p.pos.y), p.r, p.color
    'If p.id = 0 Then
    '    For i = 0 To numTypes
    '        'Circle (p.pos.x, p.pos.y), minDistances(p.id, i), _HSB32(i * colorStep + 30, 100, 100)
    '        Circle (p.pos.x, p.pos.y), radii(p.id, i), _HSB32(i * colorStep + 30, 100, 100)
    '    Next
    'End If
    'Paint Step(0, 0), Swarm(idx).type + 1
End Sub

Sub wrap (n As _Float, min As _Float, max As _Float)
    If n < min Then
        n = max
    ElseIf n > max Then
        n = min
    End If
End Sub

'$Include:'../lib/vector.bm'

Sub particle_print (p As ParticleType)
    _Dest _Console
    Print Using "particle ##: type:# pos:(###.##, ###.##) vel:(#.##, #.##) color:&"; p.id, p.type, p.pos.x, p.pos.y, p.vel.x, p.vel.y, _ToStr$(p.color)
    _Dest 0
End Sub

Function random_range (min As _Float, max As _Float)
    If min > max Then
        Swap min, max
    End If
    random_range = Rnd * (max - min) + min
End Function

Sub vector_print (v As Vector)
    _Dest _Console
    Print Using "(###.##, ###.##) ###.##"; v.x, v.y, vector_mag(v)
    _Dest 0
End Sub

Function map (n As _Float, start1 As _Float, stop1 As _Float, start2 As _Float, stop2 As _Float)
    Dim newval As _Float
    newval = (n - start1) / (stop1 - start1) * (stop2 - start2) + start2
    If start2 < stop2 Then
        constrain newval, start2, stop2
    Else
        constrain newval, stop2, start2
    End If
    map = newval
End Function

Sub constrain (n As _Float, low As _Float, high As _Float)
    n = _Max(_Min(n, high), low)
End Sub

Sub cprint (s As String)
    _Dest _Console
    Print s
    _Dest 0
End Sub
