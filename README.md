# SwiftSpace
Programming tuple spaces with Swift

## Requirements
You need an IDE, "xCode" by Apple has been used in this manual.

## How to import SwiftSpace
To import the SwiftSpace into xCode, you can simply double click the "SwiftSpace.xcodeproj" file.

## How it works
* **SpaceRepository creation with a gate**: 
```swift
let rep = SpaceRepository()
let albero = TupleSpace(TupleTree())

do {
    try rep.add("Albero", albero)
} catch {
    print("Error \(error)")
}

rep.addGate("tcp://192.168.1.68:9090/?keep")
```
* **RemoteSpace creation**:
```swift
let remote = RemoteSpace("tcp://80.182.103.158:9091/space?keep")
```
* **How to create a template and perform a match on a tuple**
```swift
let template = ["Hello World", FormalTemplateField(Int.self), 5] as [TemplateField]
template.match(tuple)
```
* **Actions on a space**

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
Example:
```swift
remote.put([5, true])
```
## Run test
From xCode: Product->Scheme->SwiftSpaceTests

Now open a test inside the SwiftSpaceTest folder, and click the diamond (near the name of the class) that indicates the run.

![Run](https://image.ibb.co/gmTZMG/Screenshot_2017_10_02_12_21_25.png)
## Run example
Copy the content of the class you want to run (inside the "Examples" folder) as the main project.
