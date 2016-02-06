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
In order to make our framework available in different platforms, we need to
create one target for each platform. I like giving them names that relate to
each of the platforms, like this:

- MyFramework**iOS**
- MyFramework**OSX**
- MyFramework**TVOS**

When we created the project in the previous
step, we already selected an iOS framework type of project. This means our
project will already contains a target for iOS. In my experience, I found it
easier to just remove that target than to rename it and the files associated.

To remove a target, we need to:

1. Select the framework and unit test targets, and delete them.

![Remove Targets](/media/swift-frameworks/4-remove-targets.png)
*Remove both framework and unit tests targets*

2. Select the project source files, and delete them.

![Remove Framework Sources](/media/swift-frameworks/5-remove-sources.png)
*Remove framework sources*

3. Select the unit test source files, and delete them.

![Remove Unit Test Sources](/media/swift-frameworks/6-remove-test-sources.png)
*Remove unit test sources*

### Adding a target for iOS
Now that our project has no targets, we are going to add three targets. To add
a new target for iOS, select the '+' icon on the project target list. Then
choose `iOS -> Framework & Library`.

![Add iOS Framework Target](/media/swift-frameworks/7-add-ios-target.png)
*Add new iOS Framework target*

When entering the name, type `MyFrameworkiOS`.

### Adding a target for OS X
Now, let's add a new target for OS X. Select the '+' icon on the project target
list. Then choose `OS X -> Framework & Library`.

![Add OS X Framework Target](/media/swift-frameworks/8-add-osx-target.png)
*Add new OS X Framework target*

When entering the name, type `MyFrameworkOSX`.

### Adding a target for tvOS
Finally, add a new target for tvOS. Select the '+' icon on the project target
list. Then choose `tvOS -> Framework & Library`.

![Add tvOS Framework Target](/media/swift-frameworks/9-add-tvos-target.png)
*Add new tvOS Framework target*

When entering the name, type `MyFrameworkTVOS`.

### Configuring shared build schemes
For continuous integration, we are going to configure one scheme for each
target. We also want to remove the scheme from the old target that we no longer
have.

Open `Projects -> Schemes -> Manage Schemes...` and check the checkbox on each
one of the schemes matching the targets we just created.

![Configure Schemes](/media/swift-frameworks/10-schemes.png)
*Configure shared schemes for each target*

* * *

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
When working with frameworks, only entities marked as `public` are accessible
from the outside. Thus, there is no much value on marking entities as `private`.

In fact, using `private` can actually make your code harder to test. Xcode 7
enables importing frameworks with `@testable import`, which makes it possible
to test non-public code. However, it cannot test private code.

* * *

## Testing

### Testing each target manually
Testing each target manually is as simple as selecting the correct scheme in
the Xcode build configuration and then running the tests (`⌘ + U`).

![Select Scheme to Build](/media/swift-frameworks/XX-schemes-testing.png)
*Selecting the scheme to test*

### Configuration for Travis CI (Continuous Integration)

* * *

## Distribution

### CocoaPods PodSpec

### Swift Package Manager

* * *

## CocoaPod dependencies
As mentioned before, Framework projects can import dependencies via CocoaPods.
Since we have created only one project for all three frameworks, adding
CocoaPods will be super easy.

In the terminal, navigate to the folder containing your Xcode project and type
the following command:

    $ pod init

This will create a `Podfile` file with some content for your multiple targets.
Alternatively, you can also create the Podfile manually with any text editor.

Add any pod dependencies. In most cases, the dependencies will be the same for
all three frameworks, so we can create a ruby function to contain all the pods
as follows:


Once you have listed your dependencies, run this command to install them (it
  is a good habit to close your project on Xcode, since moving forward we
  will use the workspace instead):

    $ pod install

Open the new workspace created by CocoaPods:

    $ open MyFrameworks.xcworkspace

At this point, your workspace should contain two projects our framework
project with our three targets and a second project from CocoaPods.

Build and test your schemes, everything should work as before, and all
dependencies included in the Podfile should be available for import.

* * *

Footnotes:

[^1]: The type of project is irrelevant as this point, as long as is a framework, since we will delete this target in favor of 3 new ones with proper target names.
[^2]: The module name can be different when using CocoaPods or Carthage to distribute a framework.
