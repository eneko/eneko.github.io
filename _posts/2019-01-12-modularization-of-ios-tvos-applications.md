---
layout: post
title: Modularization of iOS and tvOS Applications
permalink: /articles/:title
desc:
  Large iOS and tvOS applications can easily become hard to test, debug and
  maintain. Software modularization can help us mitigate those issues.
keywords: architecture, design, software, cohesion, coupling, modularization,
  module, framework, application
image: /media/articles/tvos-uifocusguide/07-all-guides.png
---

## Introduction

Software applications tend to grow over time, both in number of lines of code,
number of features, and complexity. Applications with non-well designed
software often lead to source code that is _fragile_, hard to test, and even
understand.

Unit tests make it much easier to refactor code. When tests pass, we have some
guarantee we didn't break anything with our changes. Hard to test code is by
_de facto_ hard to refactor, and because of this, hard to maintain.

💡 Good software design practices and principles aim to prevent these issues
from happening.

In practice, we can prevent most of these issues by focusing in two areas:

- Reducing **Software Coupling**
- Increasing **Software Cohesion**

If you are familiar with these concepts, feel free to skip over to
[Application-level Modules for iOS and tvOS](#application-level-modules).


## Software Coupling (aka. Dependencies) ⇄

Good software design minimizes coupling. Software with lower coupling
is better designed than software with higher coupling.

But, what is coupling? What does it mean? And, how can we reduce it?

> In software engineering, [coupling](coupling) is **the degree of
> interdependence between software modules**; a measure of how closely
> connected two routines or modules are; the strength of the relationships
> between modules.

A typical example of coupling on iOS applications is a view or UI element that
depends on (is coupled to) persistence or networking code, whether directly
or via interdependencies, like view models, data sources, or data stores.

If this UI element dependencies are hard-wired, it would make it really
hard to test it without bringing those dependencies in.

Organizing code into modules will not remove these dependencies from our code
base, but it will make it much easier to discover dependencies, helping us
isolate dependencies and preventing new ones from being introduced.


## Software Cohesion ♾

Good software design maximizes cohesion. Software with higher cohesion
is better designed than software with lower cohesion.

But, what is cohesion? What does it mean? And, how can we increase it?

> In computer programming, [cohesion](cohesion) refers to **the degree to
> which the elements inside a module belong together**. In one sense, it is
> a measure of the strength of relationship between the methods and data
> of a class and some unifying purpose or concept served by that class.
> In another sense, it is a measure of the strength of relationship between
> the class’s methods and data themselves.

Software with high cohesion is that where elements of code (methods in a class,
classes in a module, modules in a program) are grouped together in a meaningful
way.

There are many different types of cohesion, **Logical Cohesion** and
**Functional Cohesion** being the most important ones to focus on.
These will help us determine how to better group our source code.

### Logical Cohesion 🧮

Logical Cohesion is determined by the different **kinds of logic** found in
our applications. Common types of application logic include presentation,
formatting, navigation, validation, data transformation, persistence,
caching, networking, etc.

### Functional Cohesion ⒡

Functional Cohesion is determined by **application functionality (features)**.
These features are well defined and are the reason our application exists.

Examples of features are sending emails, posting articles or comments,
downloading or streaming content, image or video processing, purchasing
products or services, etc.


## Increasing Cohesion while Reducing Coupling 🤔

We can both increase cohesion and reduce coupling by **organizing in modules**
those parts of source code that are highly related to each other,
whether this is in a logical or functional way.

- For small applications with one or few features, Logical Cohesion is probably
  a good choice, since it is relatively easy to organize source code this way.

- Larger applications, however, will benefit from Functional Cohesion, where
  features can be encapsulated in separate modules.

In most cases, a mix of both Logical and Functional Cohesion is recommended.

### Benefits of Modularization 👏

#### Architectural 🏛
- Higher logical and functional cohesion
- Improved reusability (easier to reuse code)
- Improved replaceability (easier to replace and mock code)
- Better separation of concerns
- Lower coupling
- Better access control (public vs. internal vs. private)
- Smaller components are easier to maintain
- Increased security

#### Testability ✅
- Improved testability (code easier to test)
- Easier to increase code coverage

#### Performance 🏎
- Reduced compile time (only modules with changes need to be re-built)


<a name="application-level-modules" />
## Application-level Modules for iOS and tvOS 📦



At a minimum, iOS/tvOS applications could be split into three modules:
- Main Target: application delegate, view controllers and navigation logic
- UI Components: standalone elements that compose the user interface
- Business Logic: features and functionality

![Application Modules](/media/articles/modularization/application-modules.png)


### Defining logical and functional modules

### Creating framework targets

### Moving relevant code into modules

### Moving test code into modules


[coupling]: https://en.wikipedia.org/wiki/Coupling_(computer_programming)
[cohesion]: https://en.wikipedia.org/wiki/Cohesion_(computer_science)
