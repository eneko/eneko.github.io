---
layout: post
title: Running multiple asynchronous operations simultaneously with GCD and waiting for completion
date: 2016-02-16
desc: Waiting for multiple asynchronous operations to complete can be complicated.
keywords: swift, Async, AsyncGroup, GCD, asynchronous, operation, block, multiple, group, grand, central, dispatch
image: /media/articles/multiple-async-operations/async-group.png
---

Running asynchronous operations in Swift is pretty easy with Grand Central
Dispatch. Usually, completion is handled via callback blocks, which is perfect
for avoiding blocking the main thread of a GUI application running.

However, sometimes we want to run async operations from background threads or
even non-GUI applications, like command line tools. In this cases, blocking
the current thread of execution is the desired behavior.

Holding the current thread for async operations to complete is a bit
complicated[^1], and, with simple GCD async blocks, it requires the use of
semaphores[^2]. This is were we can take advantage of GCD groups.

## GCD Groups
GCD groups make it very easy to run one or multiple asynchronous operations in
parallel and waiting for all of them to complete.

~~~swift
let group = dispatch_group_create()
let queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
dispatch_group_async(group, queue) {
    // Async operation
}
dispatch_group_async(group, queue) {
    // Another async operation in parallel
}
dispatch_group_wait(group, DISPATCH_TIME_FOREVER)
// All operations complete
~~~


## AsyncGroup
**AsyncGroup** is a thin wrapper I wrote around `dispatch_group` that
facilitates working with groups of asynchronous blocks. It is now part of
[Async](https://github.com/duemunk/Async), a thin wrapper
around `dispatch_async` that provides *syntactic sugar in Swift for asynchronous
dispatches in Grand Central Dispatch*.

![AsyncGroup](/media/articles/multiple-async-operations/async-group.png)

## Usage
Multiple dispatch blocks with GCD:

~~~swift
let group = AsyncGroup()
group.background {
    // Run on background queue
}
group.utility {
    // Run on utility queue, in parallel to the previous block
}
group.wait()
// Both operations completed
~~~

All modern queue classes:

~~~swift
group.main {}
group.userInteractive {}
group.userInitiated {}
group.utility {}
group.background {}
~~~

Custom queues:

~~~swift
let customQueue = dispatch_queue_create("Label", DISPATCH_QUEUE_CONCURRENT)
group.customQueue(customQueue) {}
~~~

Custom asynchronous operations:

~~~swift
let group = AsyncGroup()
group.enter()
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    // Do stuff
    group.leave()
}
group.enter()
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
    // Do other stuff in parallel
    group.leave()
}
// Wait for both to finish
group.wait()
// Do rest of stuff
~~~

Usage with [Alamofire](https://github.com/Alamofire/Alamofire):

~~~swift
let group = AsyncGroup()
group.enter()
Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
     .responseJSON { response in
         debugPrint(response)
         group.leave()
     }
group.enter()
Alamofire.upload(.POST, "https://httpbin.org/post", file: fileURL)
    .responseJSON { response in
          debugPrint(response)
          group.leave()
    }
group.wait()
/// Both network operations have finished
~~~


[^1]: There are other utilities, like `NSOperation` and `NSOperationQueue`, that also make it easier to wait for operations to complete.
[^2]: Semaphores are a good way to wait for `dispatch_async` calls to complete, but there are many other options.
