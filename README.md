# SwiftSpace

## How to import SwiftSpace
To import the goSpace into your project, clone the repository and place it in the `src` folder, which is located at the root of your GOPATH.

```terminal
GOPATH/src/
```
Now that the repository has been placed correctly, we can start using the actual framework. This is done by importing the package `goSpace` into your project:

```go
import (
      "goSpace/goSpace/"
)
```

## Run test examples

This will create an executable that is named as the folder where the `main.go` is located. For the `bookstore` example the `go install` command will create an executable called `bookstore`. The example can now be run by the following command regardless of the location on the system.

```terminal
bookstore
```
The remaining examples are installed and run in the same way.

## How to perform tuple space operations.
The framework contains the following tuple space operation and the syntax of them looks as follows
```go
Put(ptp, x1, x2, ..., xn)
PutP(ptp, x1, x2, ..., xn)
Get(ptp, x1, x2, ..., xn)
GetP(ptp, x1, x2, ..., xn)
GetAll(ptp, x1, x2, ..., xn)
Query(ptp, x1, x2, ..., xn)
QueryP(ptp, x1, x2, ..., xn)
QueryAll(ptp, x1, x2, ..., xn)
```
For all operations `ptp` is a pointToPoint structure and `x1, x2, ..., xn` are terms. For the `put` operations the terms are values and for the remaining operations terms are either values or binding variables.

Pattern matching can be achieved by passing a binding variable, which is done by passing a pointer to the variable. This by can be done by adding a `&` infront of the variable. This is used in the `bookstore` example and looks a follows
```go
var i int
book := "Of Mice and Men"
tuplespace.Query(ptp, book, &i)
```
This is used to look up the price of the book "Of Mice and Men". After the `Query` operation the value of `i` is 200.
Note: binding variables can only be passed to get and query operations.
