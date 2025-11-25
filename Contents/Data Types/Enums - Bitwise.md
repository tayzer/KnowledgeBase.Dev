## Removing example
``
`[Flags]`
`public enum ArcAttacks`
`{`
    `None = 0,`
    `RadiantCross = 1 << 0,`
    `BlazingArc = 1 << 1,` 
    `// ... Add more Arc Attack flags`
`}`

`// Representation of the current Arc Attack (could be in a class or a variable)`
`ArcAttacks currentArcAttack = ArcAttacks.RadiantCross | ArcAttacks.BlazingArc;` 

`// Let's remove the RadiantCross flag`
`currentArcAttack &= ~ArcAttacks.RadiantCross;`

`// Now currentArcAttack would only contain the BlazingArc flag`

## Adding example

`[Flags]`
`public enum ArcAttacks`
`{`
    `None = 0,`
    `RadiantCross = 1 << 0,`
    `BlazingArc = 1 << 1,` 
    `// ... Add more Arc Attack flags`
`}`

`// Representation of the current Arc Attack` 
`ArcAttacks currentArcAttack = ArcAttacks.RadiantCross;` 

`// Let's add the BlazingArc flag`
`currentArcAttack |= ArcAttacks.BlazingArc;`

`// Now currentArcAttack would contain both RadiantCross and BlazingArc flags`` 
`