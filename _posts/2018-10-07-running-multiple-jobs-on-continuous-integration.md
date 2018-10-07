---
layout: post
title: Running Multiple Concurrent Jobs on Continuous Integration
permalink: /articles/:title
desc:
  Running multiple concurrent jobs on continuous integration allows for running
  unit tests in multiple platforms, but also for testing installation scripts,
  generating code coverage reports, and more.
keywords: swift, contigupus, integration, ci, linux, macos, swiftpm, package, manager, travis, travisci
image: /media/articles/ci-jobs/sourcedocs-travisci.png
redirect_from:
    - /foobar.html
---

![](/media/articles/ci-jobs/sourcedocs-travisci.png)

Swift projects are often distributed in multiple platforms, whether this is
macOS/iOS/tvOS/watchOS, for client side libraries and applications, or
macOS/Linux, for server-side Swift.

Modern CI providers, like [Travis CI](https://travis-ci.org) or
[Circle CI](https://circleci.com), allow for running concurrent
jobs on branch updates or pull requests.

We can take advantage of this parallelization feature to run our unit and
integration tests in multiple platforms.

But not only that. In addition, we can also run separate jobs to test other
tasks like different installation methods or generating code coverage reports.

By using parallelization, we get our CI builds to complete all jobs in a
smaller amount of time.

On this article, we will go through the configuration file for Travis CI.
However, this configuration file should be very similar in other CI providers.

## Setting Up Multiple Jobs

We assume you have a project created with Swift Package Manager (if this is not
the case, bear with me. As long as you can run your tests from the command line,
this guide might be useful to you). You should be able to run your tests
with the following command:

```
$ swift test
```

You can also run your tests in parallel with:

```
$ swift test --parallel
```

Running your tests in parallel is often a good way to ensure your tests are
independent from each other, and can be run in any order.
