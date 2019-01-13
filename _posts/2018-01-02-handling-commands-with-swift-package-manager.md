---
layout: post
permalink: /articles/:title
title: Handling Commands with Swift Package Manager ArgumentParser
date: 2018-01-02
desc:
  Swift Package Manager comes out-of-the-box with an excellent argument parser. Here is how
  to use it to handle subcommands.
keywords: argumentparser, argument, command, subcommand, swift, package, manager, spm, terminal, console, command, line, macOS, OSX, Linux
image: /media/articles/command-line-spm/calculator.png
redirect_from:
    - /2018/01/02/handling-commands-with-swift-package-manager.html
---

![Calculator](/media/articles/command-line-spm/calculator.png)

Parsing arguments in a command line application is not a trivial task. Over time,
applications can evolve to support many features, which makes the number of
arguments supported grow considerably.

For example, the impressive [`curl` command line tool has 207 different argument
options](https://gist.github.com/eneko/dc2d8edd9a4b25c5b0725dd123f98b10),
including parameters and flags.

This large amount of options makes `curl` very flexible and powerful. However,
it also makes it hard to use; hard to learn and master.

Newer command line tools, like `git`, `gem`, `carthage` or `travis`, do a better
job organize their features by grouping them in **subcommands**.

Examples:
- `git clone`, `git fetch`, `git branch`, `git commit`, `git push`...
- `gem install`, `gem update`, `gem build`...
- `carthage update`, `carthage build`, `carthage archive`...
- `travis login`, `travis monitor`, `travis status`...

Let's see how to create a command line tool that supports these types of subcommands,
by using the out-of-the-box `ArgumentParser` class from Swift Package Manager.

### Project Setup

We are going to write a very basic command line calculator to compute basic
math operations. Here is the proposed interface:

- Addition: `calculator add <x> <y> ...`
- Subtraction: `calculator subtract <x> <y> ...`
- Multiplication: `calculator multiply <x> <y> ...`
- Division: `calculator divide <x> <y> ...`

First, we create our new tool:

```terminal
$ mkdir calculator && cd calculator
$ swift package init --type executable
$ swift run calculator
Hello, world!
```

Add Swift Package Manager as a dependency on `Package.swift`:

```swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "calculator",
    dependencies: [
        .package(url: "https://github.com/apple/swift-package-manager.git", from: "0.1.0"),
        ],
    targets: [
        .target(name: "calculator", dependencies: ["Utility"]),
    ]
)
```

And generate the Xcode project:

```terminal
$ swift package generate-xcodeproj
$ open calculator.xcodeproj
```


### Command Protocol

Our commands will be based on the [subparser feature](https://github.com/apple/swift-package-manager/blob/master/Sources/Utility/ArgumentParser.swift#L715) provided by `ArgumentParser`.

```swift
public func add(subparser command: String, overview: String) -> ArgumentParser
```

This feature, allows to create nested "parsers" that can handle arguments at their
corresponding level.

Subparsers are defined by their command name and overview. We can extrapolate
this information into a protocol. In order to register our commands, we will
initialize them with the main `ArgumentParser` instance. Finally, we will place
the main command execution code inside a `run` method.

```swift
protocol Command {
    var command: String { get }
    var overview: String { get }

    init(parser: ArgumentParser)
    func run(with arguments: ArgumentParser.Result) throws
}
```

We can then create our first command:

```swift
struct AdditionCommand: Command {

    let command = "add"
    let overview = "Compute the sum of all the numbers."

    init(parser: ArgumentParser) {
        parser.add(subparser: command, overview: overview)
    }

    func run(with arguments: ArgumentParser.Result) throws {
        //
    }

}
```

### Command Parameters

A calculator would be useless if we couldn't pass in some numbers to operate with.

In this case, we are looking a positional argument, of type integer, that can
contain one or more values (an array).

```swift
private let numbers: PositionalArgument<[Int]>

init(parser: ArgumentParser) {
    let subparser = parser.add(subparser: command, overview: overview)
    numbers = subparser.add(positional: "numbers", kind: [Int].self,
                            usage: "List of numbers to operate with.")
}
```

This will allow us to pass any number of integers to compute the sum:

```terminal
$ calculator add 1 2 3 4
10
```

Now we can compute the sum with `reduce` within our `run` method:

```swift
func run(with arguments: ArgumentParser.Result) throws {
    guard let integers = arguments.get(numbers) else {
        return
    }
    let result = integers.reduce(0, +)
    print(result)
}
```

🛠 Full code of `AdditionCommand.swift`:

```swift
import Foundation
import Utility
import Basic

struct AdditionCommand: Command {

    let command = "add"
    let overview = "Compute the sum of all the numbers."

    private let numbers: PositionalArgument<[Int]>

    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numbers = subparser.add(positional: "numbers", kind: [Int].self,
                                usage: "List of numbers to operate with.")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        guard let integers = arguments.get(numbers) else {
            return
        }
        let result = integers.reduce(0, +)
        print(result)
    }

}
```


### Command Registry

Now that we can create commands, we want to easily register them so
`ArgumentParser` can help us determine which command to execute.

To do this, we are going to create a command registry, that will keep track
of our commands. All we need to keep track of is an array of commands, and
an instance of the main `ArgumentParser` class.

```swift
struct CommandRegistry {

    private var commands: [Command] = []

    mutating func register(command: Command.Type) {
        commands.append(command.init(parser: parser))
    }
}
```

To keep out `main.swift` clean and tidy, we are going to have our
`CommandRegistry` handle the following tasks:

- parse the arguments
- determine which command to execute
- execute the command by calling `run()`

First, we are going to create the main `ArgumentParser`:

```swift
private let parser: ArgumentParser

init(usage: String, overview: String) {
    parser = ArgumentParser(usage: usage, overview: overview)
}
```

This method will parse the command line arguments (only needs to be called once):

```swift
private func parse() throws -> ArgumentParser.Result {
    let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
    return try parser.parse(arguments)
}
```

We can determine the command to run by calling the `subparser()` method in the
parsed arguments results and getting the corresponding command from our registry:

```swift
private func process(arguments: ArgumentParser.Result) throws {
    guard let subparser = arguments.subparser(parser),
        let command = commands.first(where: { $0.command == subparser }) else {
        parser.printUsage(on: stdoutStream)
        return
    }
    try command.run(with: arguments)
}
```

`ArgumentParser` includes a handy `printUsage` method that we use here, for
cases where the user entered an unknown command.

🛠 Full code of `CommandRegistry.swift`:

```swift
import Foundation
import Utility
import Basic

struct CommandRegistry {

    private let parser: ArgumentParser
    private var commands: [Command] = []

    init(usage: String, overview: String) {
        parser = ArgumentParser(usage: usage, overview: overview)
    }

    mutating func register(command: Command.Type) {
        commands.append(command.init(parser: parser))
    }

    func run() {
        do {
            let parsedArguments = try parse()
            try process(arguments: parsedArguments)
        }
        catch let error as ArgumentParserError {
            print(error.description)
        }
        catch let error {
            print(error.localizedDescription)
        }
    }

    private func parse() throws -> ArgumentParser.Result {
        let arguments = Array(ProcessInfo.processInfo.arguments.dropFirst())
        return try parser.parse(arguments)
    }

    private func process(arguments: ArgumentParser.Result) throws {
        guard let subparser = arguments.subparser(parser),
            let command = commands.first(where: { $0.command == subparser }) else {
            parser.printUsage(on: stdoutStream)
            return
        }
        try command.run(with: arguments)
    }

}
```

### Main.swift

We have managed to encapsulate the command execution code in our command classes,
while the main argument parsing code is handled by the command registry.

This leaves us with a very slim `main.swift` file, really easy to maintain and
expand.

```swift
var registry = CommandRegistry(usage: "<command> <options>", overview: "Basic Calculator")

registry.register(command: AdditionCommand.self)

registry.run()
```

Running our command generates the pretty usage output:

```terminal
$ swift run calculator
OVERVIEW: Basic Calculator

USAGE: calculator <command> <options>

SUBCOMMANDS:
  add                     Compute the sum of all the numbers.
```

```terminal
$ swift run calculator add --help
OVERVIEW: Compute the sum of all the numbers.

POSITIONAL ARGUMENTS:
  numbers   List of numbers to operate with.
```

We can test it with passing some ints:

```terminal
$ swift run calculator add 400 600
1000
```

```terminal
$ .build/debug/calculator add 1 2 3 4 5 6 7 8 9 10
55
```

```terminal
$ .build/debug/calculator add 40000000000000000000000 1
'40000000000000000000000' is not convertible to Int for argument numbers; use --help to print usage
```

### Subtraction, Multiplication and Division

🛠 Full code of `SubtractionCommand.swift`:

```swift
import Foundation
import Utility
import Basic

struct SubtractionCommand: Command {

    let command = "subtract"
    let overview = "Compute the difference of all the numbers."

    private let numbers: PositionalArgument<[Int]>

    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numbers = subparser.add(positional: "numbers", kind: [Int].self,
                                usage: "List of numbers to operate with.")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        guard var integers = arguments.get(numbers) else {
            return
        }
        let first = integers.removeFirst()
        let result = integers.reduce(first, -)
        print(result)
    }

}
```

🛠 Full code of `MultiplicationCommand.swift`:

```swift
import Foundation
import Utility
import Basic

struct MultiplicationCommand: Command {

    let command = "multiply"
    let overview = "Compute the product of all the numbers."

    private let numbers: PositionalArgument<[Int]>

    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numbers = subparser.add(positional: "numbers", kind: [Int].self,
                                usage: "List of numbers to operate with.")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        guard let integers = arguments.get(numbers) else {
            return
        }
        let result = integers.reduce(1, *)
        print(result)
    }

}
```

🛠 Full code of `DivisionCommand.swift`:

```swift
import Foundation
import Utility
import Basic

struct DivisionCommand: Command {

    let command = "divide"
    let overview = "Compute the division of all the numbers."

    private let numbers: PositionalArgument<[Int]>

    init(parser: ArgumentParser) {
        let subparser = parser.add(subparser: command, overview: overview)
        numbers = subparser.add(positional: "numbers", kind: [Int].self,
                                usage: "List of numbers to operate with.")
    }

    func run(with arguments: ArgumentParser.Result) throws {
        guard var integers = arguments.get(numbers) else {
            return
        }
        let first = integers.removeFirst()
        let result = integers.reduce(first, /)
        print(result)
    }

}
```

Our updated `main.swift`:

```swift
var registry = CommandRegistry(usage: "<command> <options>", overview: "Basic Calculator")

registry.register(command: AdditionCommand.self)
registry.register(command: SubtractionCommand.self)
registry.register(command: MultiplicationCommand.self)
registry.register(command: DivisionCommand.self)

registry.run()
```

Running our tool with no parameters outputs the updated usage overview:

```terminal
$ swift run calculator
OVERVIEW: Basic Calculator

USAGE: calculator <command> <options>

SUBCOMMANDS:
  add                     Compute the sum of all the numbers.
  divide                  Compute the division of all the numbers.
  multiply                Compute the product of all the numbers.
  subtract                Compute the difference of all the numbers.
```

Some tests 💯:

```terminal
$ swift run calculator subtract 10 7 7
-4
```

```terminal
$ swift run calculator multiply 1 2 3 4 5
120
```

```terminal
$ swift run calculator divide 20 5 2
2
```

And of course:

```terminal
$ swift run calculator divide 20 0
Fatal error: Remainder of or division by zero
Illegal instruction: 4
```

😅

### Summary

As you can see, Swift Package Manager includes out-of-the-box a great set of
powerful tools. `ArgumentParser` is an excellent parser for command line
arguments.


#### Command Line Tools Series

- [Creating command line tools with Swift Package Manager](/articles/creating-command-line-tools-with-swift-package-manager)
- Manual argument parsing
- [Parsing command line arguments with SPM ArgumentParser](/articles/parsing-command-line-arguments-with-swift-package-manager-argument-parser)
- [Handling commands with ArgumentParser](/articles/handling-commands-with-swift-package-manager)
- Internet requests
- What else can you do with a command line tool?
