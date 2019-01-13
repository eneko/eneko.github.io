---
layout: post
title: Modularization of iOS and tvOS applications
permalink: /articles/:title
date: 2019-01-11
desc:
  Large iOS and tvOS applications can easily become hard to test, debug and
  maintain. Software modularization can help us mitigate those issues.
keywords: architecture, design, software, cohesion, coupling, modularization,
  module, framework, application
image: /media/articles/tvos-uifocusguide/07-all-guides.png
---

## Software Design Goals 🥅

Software applications tend to grow over time in number of lines of code,
number of features, and complexity. Applications with non-well designed
software often lead to source code that is:

- fragile
- hard to maintain
- hard to debug
- hard to test
- hard to refactor

Good software design practices and principles aim to prevent these issues
from happening.

Most of these techniques, and design patterns focus on two main goals:

- Reducing **Software Coupling**
- Increasing **Software Cohesion**

## Software Coupling ⇄

Good software design minimizes coupling. Software with lower coupling
is better designed than software with higher coupling.

But, what is coupling? What does it mean? And, how can we reduce it?


## Software Cohesion ♾

Good software design maximizes cohesion. Software with higher cohesion
is better designed than software with lower cohesion.

But, what is cohesion? What does it mean? And, how can we increase it?

> [**cohesion**](https://www.merriam-webster.com/dictionary/cohesion) noun<br>
> co·​he·​sion | \kō-ˈhē-zhən\ <br>
> Definition of _cohesion_ <br>
> 1 : the act or state of sticking together tightly

Software with high cohesion is that where elements of code (methods in a class,
classes in a module, modules in a program) are grouped together in a meaningful
way.

Cohesion is determined by the relationships between different parts of our
application source code.

There are many different types of cohesion, **Logical Cohesion** and
**Functional Cohesion** being the most important ones. These will help us
determine how to better group our source code.

### Logical Cohesion 🧮

Logical Cohesion is determined by the different types of logic found in
our applications:
- User interface logic
  - Presentation logic
  - Formatting logic
  - Navigation logic
  - etc.
- Business logic
  - Validation logic
  - Data transformation logic
  - Persistence logic
  - Networking logic
  - etc.

### Functional Cohesion ⒡

Functional Cohesion is determined by application functionality (features).
These features are well defined and are the reason the application exists.

Some feature examples are:
- Sending email
- Posting articles / comments
- Downloading or streaming content
- Image or video processing
- Scheduling or booking
- Purchasing products or services
- etc.


## Increasing Software Cohesion While Reducing Software Coupling With Modularization 📦

We can both increase cohesion and reduce coupling by **organizing in modules**
those parts of source code that are highly related to each other,
whether this is in a logical or functional way.

For small applications with one or few features, Logical Cohesion is probably
a good choice, since it is relatively easy to organize source code this way.

Larger applications, however, will benefit from Functional Cohesion, where
features can be encapsulated in separate modules.

In most cases, a mix of both Logical and Functional Cohesion is recommended.


### Benefits of Modularization 👏

### Architecture 🏛
- Higher logical and functional cohesion
- Improved reusability (easier to reuse code)
- Improved replaceability (easier to replace and mock code)
- Better separation of concerns
- Lower coupling
- Better access control (public vs. internal vs. private)
- Smaller components are easier to maintain
- Increased security

### Testability ✅
- Improved testability (code easier to test)
- Easier to increase code coverage

### Performance 🏎
- Reduced compile time (only modules with changes need to be re-built)


## Modularization of iOS and tvOS applications

At a minimum, iOS/tvOS applications could be split into three modules:
- Main Target: application delegate, view controllers and navigation logic
- UI Components: standalone elements that compose the user interface
- Business Logic: features and functionality

![Application Modules](/media/articles/modularization/application-modules.png)


### Defining logical and functional modules

### Creating framework targets

### Moving relevant code into modules

### Moving test code into modules
