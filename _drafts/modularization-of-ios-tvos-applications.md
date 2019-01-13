---
layout: post
title: Modularization of iOS/tvOS applications
permalink: /articles/:title
desc:
  Large iOS and tvOS applications can easily become hard to test, debug and
  maintain. Software modularization can help us mitigate those issues.
keywords: architecture, design, software, cohesion, coupling, modularization,
  module, framework, application
image: /media/articles/tvos-uifocusguide/07-all-guides.png
---


## Software Coupling


## Software Cohesion

Good software architectures maximize cohesion. Software with higher cohesion
is better designed than software with lower cohesion.

But, what is cohesion? What does it mean? And, how can we increase it?

Cohesion is defined as [_the act or state of sticking together tightly_](https://www.merriam-webster.com/dictionary/cohesion). Software with high cohesion
is that where elements of code (methods in a class, classes in a module) are
grouped together in a meaningful way.

There are different types of cohesion, the two more important are Logical
Cohesion and Functional Cohesion.

**Logical Cohesion** is determined by the different types of logic found in
our application:
- user interface logic (presentation, formatting...)
- business logic (validation, data transformation, persistence, networking...)

**Functional Cohesion** is determined by application functionality, also known
as features. These features are often unique to each application and are the
reason the application exists. Some feature examples are:
- Send an email
- Post an article / comment
- Download or stream content
- Image or video processing
- etc.

### Increasing Cohesion

We can increase cohesion by organizing in modules parts of source code that are
highly related to each other, in a logical or functional way.

At a minimum, applications could be split into three modules:
- Main target: application target containing view controllers and navigation
  logic
- UI components: standalone elements that compose parts of the
  user interface


## Benefits of Modularization

### Architecture
- Higher logical and functional cohesion
- Improved reusability (easier to reuse code)
- Improved replaceability (easier to replace and mock code)
- Better separation of concerns
- Lower coupling
- Better access control (public vs. internal vs. private)
- Smaller components are easier to maintain
- Increased security

### Testability
- Improved testability (code easier to test)
- Easier to increase code coverage

### Performance
- Reduced compile time (only modules with changes need to be re-built)


## Modularization of iOS/tvOS applications

### Defining logical and functional modules

### Creating framework targets

### Moving relevant code into modules

### Moving test code into modules
