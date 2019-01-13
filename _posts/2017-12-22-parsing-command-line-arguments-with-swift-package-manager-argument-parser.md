---
layout: post
permalink: /articles/:title
title: Parsing Strongly-Typed Command Line Arguments with Swift Package Manager ArgumentParser
date: 2017-12-22
desc:
  Swift Package Manager comes out-of-the-box with an excellent argument parser. Here is how
  to use it in your own project.
keywords: argumentparser, argument, swift, package, manager, spm, terminal, console, command, line, macOS, OSX, Linux
image: /media/articles/command-line-spm/argument-parser.png
redirect_from:
    - /2017/12/20/parsing-command-line-arguments-with-swift-package-manager-argument-parser.html
---


The Swift Package Manager provides an out-of-the-box, strongly-typed argument parser
that can be used without adding other third party dependencies.

![Using ArgumentParser](/media/articles/command-line-spm/argument-parser.png)

### Configuration

First, we need to add the `Utility` framework included in Swift Package
Manager as a dependency to our project:

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "mycommandlinetool",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
    ],
    targets: [
        .target(name: "mycommandlinetool", dependencies: ["Utility"]),
    ]
)
```

Then update our project:
```
$ swift package update
Fetching https://github.com/apple/swift-package-manager.git
Cloning https://github.com/apple/swift-package-manager.git
Resolving https://github.com/apple/swift-package-manager.git at 0.1.0

$ swift package generate-xcodeproj
generated: ./mycommandlinetool.xcodeproj
```


### Initial Parsing and `--help`

Now, we can import the `Utility` framework and proceed to parse the arguments:

```swift
import Foundation
import Utility

// The first argument is always the executable, drop it
let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())

let parser = ArgumentParser(usage: "<options>", overview: "This is what this tool is for")
let parsedArguments = try parser.parse(arguments)
```

Then we can run the `--help` command to see the usage and overview:
```
$ swift run mycommandlinetool --help
OVERVIEW: This is what this tool is for

USAGE: mycommandlinetool <options>
```


### Strongly-Typed Arguments

`ArgumentParser` supports strongly-typed arguments, as follows:

```swift
let number: OptionArgument<Int> = parser.add(option: "--number", shortName: "-n", kind: Int.self, usage: "A number to compute")
```

The help command would now print:

```
$ swift run mycommandlinetool --help
OVERVIEW: This is what this tool is for

USAGE: mycommandlinetool <options>

OPTIONS:
  --number, -n
             A number to compute
  --help     Display available options
```

To get the argument value, we can simply check with `if let`:

```swift
if let integer = parsedArguments.get(number) {
    print("Your number is \(integer)")
}
```

And run it like:
```
$ swift run mycommandlinetool --number 6
Your number is 6
$ swift run mycommandlinetool -n 6
Your number is 6
```

For command line flags, we can use boolean options:
```swift
let uppercased: OptionArgument<Bool> = parser.add(option: "--uppercased", kind: Bool.self)
```

And run it like:
```
$ swift run mycommandlinetool -n 6 --uppercased
YOUR NUMBER IS 6
```


### Handling parse errors

`ArgumentParser` will raise a exception when arguments cannot be parsed as
expected. Typical thrown errors are:

- Unexpected positional parameters or options are found
- Argument type does not match the option

When an exception is thrown at the top level, the Swift command line tool will be
terminated with a non-very-friendly error message like this:

```
$ swift run mycommandlinetool -n foo
Fatal error: Error raised at top level: 'foo' is not convertible to Int for argument --number; use --help to print usage: file /BuildRoot/Library/Caches/com.apple.xbs/Sources/swiftlang/swiftlang-900.0.74.1/src/swift/stdlib/public/core/ErrorType.swift, line 187
Illegal instruction: 4
```

`ArgumentParser` exceptions can be easily cached as follows:

```swift
do {
    let parsedArguments = try parser.parse(arguments)
    processArguments(arguments: parsedArguments)
}
catch let error as ArgumentParserError {
    print(error.description)
}
catch let error {
    print(error.localizedDescription)
}
```

Which would print a more user-friendly error message.

```
$ swift run mycommandlinetool -n foo
'foo' is not convertible to Int for argument --number; use --help to print usage
```


### Full source code

```swift
import Foundation
import Utility

// The first argument is always the executable, drop it
let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())

let parser = ArgumentParser(usage: "<options>", overview: "This is what this tool is for")
let number: OptionArgument<Int> = parser.add(option: "--number", shortName: "-n", kind: Int.self, usage: "A number to compute")
let uppercased: OptionArgument<Bool> = parser.add(option: "--uppercased", kind: Bool.self)

func processArguments(arguments: ArgumentParser.Result) {
    if let integer = arguments.get(number) {
        let message = "Your number is \(integer)"
        if arguments.get(uppercased) == true {
            print(message.uppercased())
        } else {
            print(message)
        }
    }
}

do {
    let parsedArguments = try parser.parse(arguments)
    processArguments(arguments: parsedArguments)
}
catch let error as ArgumentParserError {
    print(error.description)
}
catch let error {
    print(error.localizedDescription)
}
```

#### Command Line Tools Series

- [Creating command line tools with Swift Package Manager](/articles/creating-command-line-tools-with-swift-package-manager)
- Manual argument parsing
- [Parsing command line arguments with SPM ArgumentParser](/articles/parsing-command-line-arguments-with-swift-package-manager-argument-parser)
- [Handling commands with ArgumentParser](/articles/handling-commands-with-swift-package-manager)
- Internet requests
- What else can you do with a command line tool?
