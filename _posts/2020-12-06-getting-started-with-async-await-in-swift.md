---
layout: post
title: Getting started with async/await in Swift
permalink: /articles/getting-started-with-async-await-in-swift
date: 2020-12-06
desc: Hands-on experience with async/await in Swift
image: /media/articles/async-await/async-await-demo.png
keywords: swift, async, await, callback, closure, concurrency
redirect_from:
  - /2020/12/06/getting-started-with-async-await-in-swift.html
---

If you are eager to test the new `async`/`await` Swift feature, you are lucky. Three new
Swift evolution proposals have been drafted, the first one submitted and in review. These proposals
have been partially implemented (available in the latest snapshots from `main` branch).

- [Proposal SE-0296: Async/await](https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md)
- [Proposal SE-NNNN: Structured concurrency](https://github.com/DougGregor/swift-evolution/blob/structured-concurrency/proposals/nnnn-structured-concurrency.md)
- [Proposal SE-NNNN: Concurrency Interoperability with Objective-C](https://github.com/DougGregor/swift-evolution/blob/concurrency-objc/proposals/NNNN-concurrency-objc.md)

Before you get started, please consider this:

> NOTE: The implementation on these proposals is not final, and it might change while the
> proposals are being reviewed. Furthermore, these implementations are buildig blocks, which on
> their own do not provide enough funtionality for fully taking advantage of `async`/`await`.

Here are the steps to get you set up.

## Install the latest Swift Snapshot

If you are on a Mac, you can download the latest Swift snapshot (Dec 5) for Xode from this url:

[https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2020-12-05-a/swift-DEVELOPMENT-SNAPSHOT-2020-12-05-a-osx.pkg](https://swift.org/builds/development/xcode/swift-DEVELOPMENT-SNAPSHOT-2020-12-05-a/swift-DEVELOPMENT-SNAPSHOT-2020-12-05-a-osx.pkg)

Other platforms are available on the [downloads page](https://swift.org/download/#snapshots).

Once downloaded, install the package and proceed to the next step to configure Xcode.

## Configure Xcode

In Xcode, open `Xcode -> Prefences` and navigate to `Components -> Toolchains`. From the list,
select the Swift toolchain just installed (Dec 5)

![Xcode Toolchain](/media/articles/async-await/xcode-toolchain.png)

## Package Setup

For me, the easiest way to test new stuff is from the command line (I find executables super easy to
set up).

In the command line, make a new folder (any name you want) and `cd` into it:

```
mkdir async-await-cli-demo
cd async-await-cli-demo
```

Create a new Swift executable:

```
swift package init --type executable
```

Open the package in Xcode:

```
open Package.swift
```

Edit `Package.swift` to add the Swift compiler flags `-Xfrontend -enable-experimental-concurrency`.
Your package manifest should look something like this:

```swift
// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "async-await-cli-demo",
    dependencies: [
    ],
    targets: [
        .target(
            name: "async-await-cli-demo",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags([
                    "-Xfrontend",
                    "-enable-experimental-concurrency"
                ])
            ]
        ),
        .testTarget(
            name: "async-await-cli-demoTests",
            dependencies: ["async-await-cli-demo"]
        ),
    ]
)
```

## Write some code

In Xcode, open `main.swift` and proceed to write our first async function!

```swift
func asyncMethod(name: String) async {
    for x in 1...3 {
        print("Async hello, \(name)! \(x)")
        sleep(1)
    }
}
```

This method will print three messages to the console, sequentially, one second apart.

Turns out, we cannot call this method from `main.swift`, not even within a `DispatchQueue.main.async` block.
[As stated in the proposal](https://github.com/apple/swift-evolution/blob/main/proposals/0296-async-await.md#launching-async-tasks), this in intentional:

> Because only async code can call other async code, this proposal provides no way to initiate asynchronous
> code. This is intentional: all asynchronous code runs within the context of a "task"

The idea behind this is that synchronous code (e.g. main thread of an application) will need to define
asynchronous entry points, something covered in the [Structured Currency](https://github.com/DougGregor/swift-evolution/blob/structured-concurrency/proposals/nnnn-structured-concurrency.md) proposal.

I was bummed for a little bit, because I really wanted to test this code out. I played a bit with `DispatchQueue` and `Task`, but decided to reach out for help. Thanks to [Doug Gregor's quick response on Twitter](https://twitter.com/dgregor79/status/1335671565497733120),
I was able to borrow his test extensions and move past this point.

```swift
extension DispatchQueue {
    func async<R>(execute: @escaping () async throws -> R) -> Task.Handle<R> {
        let handle = Task.runDetached(operation: execute)

        // Run the task
        _ = {
            self.async {
                handle.run() // deprecated method, for testing purposes only
            }
        }()

        return handle
    }

    @discardableResult
    func async<R>(in group: DispatchGroup,
                  execute: @escaping () async throws -> R) -> Task.Handle<R> {
        let handle = Task.runDetached(operation: execute)

        // Run the task
        group.enter()
        _ = {
            self.async {
                handle.run() // deprecated method, for testing purposes only
                group.leave()
            }
        }()

        return handle
    }
}
```

The above two extensions allow launching an async task from a `DispatchQueue`, with or without a `DispatchGroup`. Note the `run()` method is flagged as deprecated, and it is intended for testing
purposes only.

## Calling asynchronous code

With the above extensions, we can write code like this:

```swift
let group = DispatchGroup()

DispatchQueue.global().async(in: group) {
    await asyncMethod(name: "single")
}
group.wait()
```

This code will print the following:
```
Async hello, single! 1
Async hello, single! 2
Async hello, single! 3
```

Not bad, our first use of `async`/`await`. Non-blocking code without callback closures 🎉

### Sequential calls

Let's try sequential calls:

```swift
DispatchQueue.global().async(in: group) {
    await asyncMethod(name: "first")
    await asyncMethod(name: "second")
}
group.wait()
```

This code will execute the two async methods sequentially, one after another, and print:

```
Async hello, first! 1
Async hello, first! 2
Async hello, first! 3
Async hello, second! 1
Async hello, second! 2
Async hello, second! 3
```

No more _piramid of doom_, promises or futures needed!

Note that using `await`, we can use the result of the first async operation as a parameter for the second one:

```swift
func sum(_ a: Int, _ b: Int) async -> Int {
    return a + b
}

DispatchQueue.global().async(in: group) {
    let c = await sum(1, 2)
    let d = await sum(c, 3)
    print(d) // 6
}
group.wait()
```

### Parallel/concurrent calls

According to the documentation for [Child Tasks](https://github.com/DougGregor/swift-evolution/blob/structured-concurrency/proposals/nnnn-structured-concurrency.md#child-tasks), the following code should work:

```swift
DispatchQueue.global().async(in: group) {
    async let foo = sum(1,2) // error: Call is 'async' in an 'async let' initializer that is not marked with 'await'
    async let bar = sum(3,4) // error: Call is 'async' in an 'async let' initializer that is not marked with 'await'
    print(await foo + bar)
}
group.wait()
```
`async let` assignments look very interesting and powerful. Seems like a great way to structure concurrent code.

Meanwhile, we can achieve parallelism as we are used to, by using separate group tasks:

```swift
var foo: Int = 0
DispatchQueue.global().async(in: group) {
    foo = await sum(1,2)
}
var bar: Int = 0
DispatchQueue.global().async(in: group) {
    bar = await sum(3,4)
}
group.wait()
print(foo + bar)
```

While this code works, it is prone to errors, including thread-safety. I'm hoping for the `async let` implementation to be finished soon.

## My thoughts

I have no much to say, actually, other than `async`/`await` is awesome and cannot be more grateful for all
the people that have worked hard for making this happen.

I firmly believe this will be one of the most important additions to the Swift language, if not the most.
Chances are this will have great impact in how we write code in the future. And this is for the better of
the entire Swift community.
