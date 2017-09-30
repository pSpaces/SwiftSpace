# SwiftSpace

## How to import SwiftSpace
To import the SwiftSpace into xCode, you can simply double click the "SwiftSpace.xcodeproj" file.

## Run test examples

## How to perform tuple space operations.
The framework contains the following tuple space operation and the syntax of them looks as follows
```
put([x1, x2, ..., xn])
get([x1, x2, ..., xn])
getp([x1, x2, ..., xn])
getAll([x1, x2, ..., xn])
getAll()
query([x1, x2, ..., xn])
queryp([x1, x2, ..., xn])
queryAll([x1, x2, ..., xn])
queryAll()
```
Pattern matching with TemplateField and FormalTemplateField example:
```swift
tuplespace.query(["Hello World", FormalTemplateField(Int.self), 5])
```
