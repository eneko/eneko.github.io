---
layout: post
permalink: /articles/:title
title: Terminating applications with style
date: 2018-03-02
desc:
  Terminating an application in Swift.
keywords: swift
image: /media/articles/swift/boom.png
redirect_from:
    - /2018/02/19/understanding-and-visualizing-uifocusguide-on-tvos.html
---

# die

Terminating a Swift application with style:

```swift
func die<T>(_ message: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> T {
    preconditionFailure(message, file: file, line: line)
}
```

## Forced Unwrapping: A Horrible Way to Die
Swift is a beautiful language that provides `Optional<T>` as a native solution to prevent null-pointer exceptions. However, quite sadly, Swift also provides an easy, lazy way to get around optionals: [forced unwrapping](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html).

Using forced unwrapping in Swift is a bad practice ([shame](https://pbs.twimg.com/media/CJISTV6UEAERwqU.jpg) on you!).

Why, you might ask? Turns out that one of the most common causes in computer history for a program to crash is a Null-Pointer Exception. If you would like to read more about it, I recommend reading [Null-Pointer Exception Hell](http://dobegin.com/npe-hell/) by Daniel Lazarenko (including the Swift section).

An unrecoverable situation might happen when a table view cell cannot be dequeued. This should probably never happen,
but in the case it did, we would want to know about it.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as! MyTableViewCell // crash! 💥💥💥
    cell.update(...)
    return cell
}
```


Crashes require debugging and, often, provide few cryptic information of little use to developers.

## Unrecoverable Situations
Our goal should always be to prevent unexpected crashes. This will provide the best user experience for your applications.

Sometimes, however, a program execution can reach an impasse. If there is no reasonable way out, the only way to proceed is to terminate the application.

Swift provides a few methods to stop the program execution:

- `fatalError(_:file:line:)`
    > Unconditionally prints a given message and stops execution.

    This method will terminate the application both in Debug and Release modes. However, it will output a provided message, and include the file name and line number.

- `preconditionFailure(_:file:line:)`
    > Indicates that a precondition was violated.

    This method will stop the debugger while running in Debug mode, and terminate the application when running in Release mode. It will also output the provided message, together with the file and line numbers.

- `assertionFailure(_:file:line:)`
    > Indicates that an internal sanity check failed.

    This method will stop the debugger while running in debug mode, and do nothing when running in Release mode.

We can improve the previous code using `guard` and `preconditionFailure` or `fatalError` to indicate the reason why we
cannot continue execution:

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell") as? MyTableViewCell else {
        fatalError("Could not get cell")
    }
    cell.update(...)
    return cell
}
```
