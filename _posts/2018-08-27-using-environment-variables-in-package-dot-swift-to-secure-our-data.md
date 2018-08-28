---
layout: post
permalink: /articles/:title
title: Using environment variables in Package.swift to Secure Our Data
date: 2018-08-27
desc:
  By using environment variables in Package.swift we can access
  private tokens and other secure data without having to commit those
  to our repository.
keywords: Swift, SwiftPM, Package, Manager, environment, variable, spm
image: /media/articles/package-swift/01-package-swift.png
redirect_from:
    - /2018/08/27/using-environment-variables-in-package-dot-swift-to-secure-our-data.html
---

![Environment Variables in Package Swift](/media/articles/package-swift/01-package-swift.png)

### Reading Environment Variables in Swift with `ProcessInfo`

`ProcessInfo` contains information about the current process, which
we can access via the `ProcessInfo.processInfo` class method.

From there we can read (and `print()`, if needed) all environment variables, as
we would do with any other `Dictionary`:

```swift
import Foundation

print(ProcessInfo.processInfo.environment)
print(ProcessInfo.processInfo.environment["HOME"])

```

View [`ProcessInfo` documentation](https://developer.apple.com/documentation/foundation/processinfo).

### Private Access Tokens for Private Git Repositories

If you work at an organization were your project dependencies are stored in
private git repositories, you will probably already use a private access token
with [Carthage](https://github.com/Carthage/Carthage/pull/605), 
[Fastlane](https://docs.fastlane.tools/actions/set_github_release/) 
or other scripting tools.

Swift Package Manager can access dependencies stored in private repositories,
as long as an access token in included in the url.

For GitHub, these private access tokens are obtained from your GitHub user
profile developer settings, under
[Personal access tokens](https://github.com/settings/tokens).

For GitHub, embedding tokens in the url looks like this:

```swift
import PackageDescription
let package = Package(
    name: "YourPackage",
    dependencies: [
        .package(url: "https://<github-token>:x-oauth-basic@github.com/organization/repository.git", from: "1.0.0")
    ],
)
```

The above code will let you use dependencies from private repositories. However,
it requires committing the access token to the repository.

### Using `ProcessInfo` in `Package.swift` 🎉

By using environment variables within `Package.swift`, we gain access to private
access tokens and other data we might want to use, without having to commit
those to our source repository.

```swift
import PackageDescription
import Foundation

let githubToken = ProcessInfo.processInfo.environment["GITHUB_ACCESS_TOKEN"] ?? ""

let package = Package(
    name: "YourPackage",
    dependencies: [
        .package(url: "https://\(githubToken):x-oauth-basic@github.com/organization/repository.git", from: "1.0.0")
    ],
)
```

### Works with your CI ❤️

Most CI tools nowadays allow for configuring environment variables. Once the
environment variable is configured, you should be good to go.

On Travis CI, we can do this on the repository settings screen.

![Travis CI Environment Variables](/media/articles/package-swift/02-travis-ci-environment-variables.png)

Read more about [Best Practices in Securing Your Data](https://docs.travis-ci.com/user/best-practices-security/#Steps-Travis-CI-takes-to-secure-your-data)
