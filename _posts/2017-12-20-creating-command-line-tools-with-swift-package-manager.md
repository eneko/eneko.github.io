---
layout: post
permalink: /articles/:title
title: Creating command line tools for macOS and Linux with Swift Package Manager
date: 2017-12-20
desc:
  While there are many scripting languages available to create command line tools,
  creating binary executables has many benefits. Specially when you can write them
  in Swift.
keywords: swift, package, manager, spm, terminal, console, command, line, macOS, OSX, Linux
image: /media/articles/command-line-spm/spm-init.png
redirect_from:
    - /2017/12/20/creating-command-line-tools-with-swift-package-manager.html
---

![Creating a new executable](/media/articles/command-line-spm/spm-init.png)

While there are many scripting languages available to create command line tools,
creating binary executables has many benefits. Specially when you can write them
in Swift.

These are the minimum steps to create a new command line tool and run it:

```
$ mkdir mycommandlinetool
$ cd mycommandlinetool
$ swift package init --type executable
$ swift run
Hello world!
```

To generate an Xcode project, you can run:

```
$ swift package generate-xcodeproj
generated: ./mycommandlinetool.xcodeproj
```

![Running the project on Xcode](/media/articles/command-line-spm/xcode.png)


Keep this command handy, as you will need to regenerate the Xcode project
when adding new dependencies to the `Package.swift` file.


#### Up next

- Manual argument parsing
- [Parsing command line arguments with SPM ArgumentParser](/articles/parsing-command-line-arguments-with-swift-package-manager-argument-parser)
- Writing commands with ArgumentParser
- Internet requests
- Connecting to MySQL
- What else can you do with a command line tool?
