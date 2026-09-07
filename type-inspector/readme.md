This utility scans a *.bas file for user Type definitions, and generates procedures to print out the values
for each Type found.

For example if we had a User type in `example.bas`

```bas
Type UserType
    name As String
    age As Single
End Type
```

running the source through the main executable generates sub:

```bas
Sub inspect_UserType (T as UserType)
     print "UserType:"
     print "    .name = " + T.name
     print "    .age = " + _tostr$(T.age)
End Sub
```

It does not currently handle Types inside of a Type.


