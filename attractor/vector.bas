$IncludeOnce

Type Vector
    x As Single
    y As Single
End Type


Sub vector_add (v1 As Vector, v2 As Vector)
    v1.x = v1.x + v2.x
    v1.y = v1.y + v2.y
End Sub

Sub vector_sub (v1 As Vector, v2 As Vector)
    Dim v As Vector
    vector_copy v, v2
    vector_mul v, -1
    vector_add v1, v
End Sub

Sub vector_limit (v As Vector, s As Single)
    Dim As Single value
    value = _Min(vector_mag(v), s)
    vector_unit v
    vector_mul v, value
End Sub

Sub vector_mul (v As Vector, s As Single)
    v.x = v.x * s
    v.y = v.y * s
End Sub

Function vector_mag (v As Vector)
    vector_mag = Sqr(v.x * v.x + v.y * v.y)
End Function

Sub vector_normalize (v As Vector)
    v.x = v.x / vector_mag(v)
    v.y = v.y / vector_mag(v)
End Sub

Sub vector_copy (v1 As Vector, v2 As Vector)
    v1.x = v2.x
    v1.y = v2.y
End Sub

Sub vector_set (v As Vector, x As Single, y As Single)
    v.x = x
    v.y = y
End Sub

Function vector_dist (v1 As Vector, v2 As Vector)
    Dim s
    s = Sqr((v2.x - v1.x) ^ 2 + (v2.y - v1.y) ^ 2)
    vector_dist = s
End Function

Sub vector_unit (v As Vector)
    Dim As Single m
    m = vector_mag(v)
    v.x = v.x / m
    v.y = v.y / m
End Sub

