---
layout: post
title: Creating Swift Frameworks for iOS, OS X and tvOS
date: 2016-02-04
desc: In this article I cover how to create Swift Frameworks for iOS, OS X and tvOS in Xcode 7.
keywords: swift, tvos, ios, osx, appletv, framework
image: /media/swift-frameworks/1-create-framework-project.png
---

There are many ways to make code easily reusable in Apple platforms. For
instance, although not highly recommendable, code can
easily be placed in Swift files and copied from one project to another. This
method works well in general, but it is hard to manage versions and it is prone
to errors.

### Introduction to Frameworks and Package Managers
Traditionally, on Apple platforms, reusable code will be packed and distributed
as frameworks (bundled files with extension `.framework`).

In the last few years, other package managers have become very popular, like
CocoaPods, Carthage or the new Swift Package Manager.

These package managers do not require for the code to be put inside a framework.
They can pack and distribute the code directly without the need for any project
whatsoever.

However, in my experience, **I have found three major benefits when using
frameworks for my libraries and SDKs**:

1. Frameworks can include Unit Tests without the need for Example projects.
2. Frameworks can be distributed via CocoaPods or Carthage.
3. Frameworks can include dependencies via CocoaPods and Carthage.

Furthermore, Frameworks can have CocoaPod dependencies while being distributed
as a CocoaPod, with unit tests included!

On this article I will cover how to create an Xcode project for a framework for
multiple platforms (iOS, OS X and tvOS) while reusing the source code and unit
tests. We will also cover distribution via CocoaPods and CocoaPod dependencies.

* * *

## Project Setup
Once you have some reusable code that would do for a good framework, it is time
to set up a framework project.

### Creating a Git repository
On your terminal (or Finder), create a folder/directory where your Git
repository will be located.

    $ mkdir ~/dev/MyFramework.swift
    $ cd ~/dev/MyFramework.swift

And initialize Git:

    $ git init

Alternatively, if you are using GitHub, you can directly create the repository
in GitHub and clone it in your computer.  The benefits of this approach is that
you can have GitHub generate the `README`, `.gitignore` and `LICENSE` files for
you.

I personally like the `.gitignore` that GitHub provides, with many exceptions
already included on it. See [GitHub .gitignore template example](https://raw.githubusercontent.com/eneko/BSTPriorityQueue.swift/master/.gitignore)

### Configuring the shared Sources and Tests folders
Before creating the Xcode project, we are going to set up two folders where our
source code and unit tests will live. These folders will be shared across all
three frameworks (iOS, OS X and tvOS).

    $ mkdir Sources
    $ mkdir Tests

At this point, the content of your repository root should look something like
this:

    .git
    .gitignore
    LICENSE
    README.md
    Sources/
    Tests/

### Creating the Xcode 7 Project
Open Xcode 7 and press `⇧ + ⌘ + N` to create a new project. For now, choose
`Cocoa Touch Framework` under `iOS -> Framework & Library` category [^1].

![Create Framework Project](/media/swift-frameworks/1-create-framework-project.png)
*Creating a Framework Project in Xcode 7*

Enter the name of your Framework. This should be the name you would like to use
when distributing your Framework. This WILL be the name of the Swift module
other developers will have to use when importing the framework into their
applications [^2].

![Framework Name](/media/swift-frameworks/2-framework-name.png)
*Framework Name*

![Framework Configuration](/media/swift-frameworks/3-framework-screen.png)
*Framework Project*

### Removing the default target

### Adding a target for iOS

### Adding a target for OS X

### Adding a target for tvOS

### Configuring shared build schemes

## Development

### Adding source files

### Adding test files

### Public
In Swift, the `public` keyword indicates the code flagged as public will
accessible from outside the current module.

> Public access enables entities to be used within any source file from their
> defining module, and also in a source file from another module that imports
> the defining module. You typically use public access when specifying the
> public interface to a framework.
[Access Control in Swift](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/AccessControl.html)

Using `public` in source code of an iOS, OS X or tvOS application does not
provide any direct value, since all files added to the application will be
within the application module.

However, for an application to be able to access the source
code inside a framework, it is necessary to use `public` to *expose* the
entities that we want to make accessible.

*TL,DR: Only those entities flagged as public in your framework will be
accessible from other frameworks.*

### Private

While using `private` in your properties, types and methods is totally fine, it
makes it harder to test your code.

When writing frameworks, I avoid using `private` to enable the code to
be tested using `@testable import`.

## Testing

### Testing each target manually

### Configuration for Travis CI (Continuous Integration)

## Distribution

### CocoaPods PodSpec

### Swift Package Manager

## CocoaPod dependencies


* * *

Footnotes:

[^1]: The type of project is irrelevant as this point, as long as is a framework, since we will delete this target in favor of 3 new ones with proper target names.
[^2]: The module name can be different when using CocoaPods or Carthage to distribute a framework.
