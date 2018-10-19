---
layout: post
permalink: /articles/:title
title: Understanding and Visualizing UIFocusGuide on tvOS
date: 2018-02-19
desc:
  Working with tvOS can be tedious if the focus engine cannot infer the user
  interface layout. Let's see how UIFocusGuide can help us.
keywords: tvos, uifocusguide, layout, focus, guide, appletv, swift
image: /media/articles/tvos-uifocusguide/07-all-guides.png
redirect_from:
    - /2018/02/19/understanding-and-visualizing-uifocusguide-on-tvos.html
    - /articles/understanding-and-visualizing-uifocusguide-on-tvOS
---

![UIFocusGuide](/media/articles/tvos-uifocusguide/07-all-guides.png)

Working with tvOS can be tedious if the focus engine cannot infer the user
interface layout. Let's see how `UIFocusGuide` can help us.

# Limitations of the Focus Engine

[Apple TV focus engine](https://developer.apple.com/library/content/documentation/General/Conceptual/AppleTV_PG/WorkingwiththeAppleTVRemote.html)
is quite powerful, designed to be easy to use for users
navigating our applications. UI components like Tab Bars, Table Views or
Collection Views provide a lot of functionality out-of-the-box to make
applications and layouts easy to navigate with minimal coding involved.

There are times, however, when custom layouts (based on stack views and buttons,
for example) might be a better fit for our application.

Apple tvOS focus engine can automatically transfer the focus
between buttons that are perfectly aligned on screen. Swiping on the remote
vertically or horizontally lets the user navigate from button to button
(in most cases).

Now, if the buttons are not aligned, the focus engine cannot "connect" them
automatically. This is when we get to write some beautiful Swift code 💻.

# UIFocusGuide to the Rescue

`UIFocusGuide` will allow us redirect the focus to any element on screen. It
might be a bit hard to understand how it works at first. Good news is they are
quite simple to use, once we figure out where to put them on screen.

The [documentation](https://developer.apple.com/documentation/uikit/uifocusguide)
from Apple is very scarce, as usual, but provides a few hints:

> `UIFocusGuide`
>
> An object that exposes nonview areas as focusable.
>
> As a subclass of `UILayoutGuide`, a focus guide is not a view and does not
> define a new view or participate in the view hierarchy at all, except as an
> Auto Layout guide. Unlike `UILayoutGuide`, `UIFocusGuide` represents an
> **invisible**, **focusable region** that can **redirect focus** movement to
> other views.

There are three important clues on that last sentence:

- **Invisible:** Focus guides added to the layout will not render anything on
    screen. They are part of the layout, but from the user's point of view,
    they do not exist.

- **Focusable Region:** Focus guides are a region. A rectangular (or square)
    region, to be precise. They have a frame (`layoutFrame`) but, most
    importantly, they can be anchored to other elements in the user interface
    via auto-layout constraints.

- **Redirect Focus:** Focus guides are invisible, and as such, cannot represent
    a focused state on screen. Instead, when focused, they can redirect the
    focus to other views.

# Adding Focus Guides

The following screenshot is from the
[Grand Prix Stats Apple TV](http://www.enekoalonso.com/projects/grand-prix-stats/)
application.

![UIFocusGuide](/media/articles/tvos-uifocusguide/01-initial-state.png)
*Initial State*

The top three buttons on screen are inside a vertical `UIStackView`, being the
first button the preferred focused view. The focus engine is capable of moving
the focus from one button to another in the stack, when swiping up and down on
the remote (or pressing the up/down keys on the simulator).

However, the focus engine does not know how to get to the two buttons at the
bottom-left and bottom-right of the screen.

## From Constructors' Championship to 2018

We want users to be able to **swipe down** to move focus from the
[Constructors' Championship] button to the [2018] (next season) button in the
bottom-left of the screen.

![UIFocusGuide](/media/articles/tvos-uifocusguide/02-stuck.png)
*Need some guidance to move focus to the bottom-left button.*

We are going to add a `UIFocusGuide` right under the [Constructors' Championship]
button.

Remember focus guides are a rectangular area. To make it easier later on,
we will make the focus guide the same size as the origin view, in this case the
[Constructors' Championship] button, and will attach it using auto-layout
anchors to the bottom of the button.

```swift
let origin = constructorsStandingsButton
let destination = nextSeasonButton // 2018 button
let focusGuide = UIFocusGuide()
view.addLayoutGuide(focusGuide)

// Indicate where to transfer focus
focusGuide.preferredFocusEnvironments = [destination]

// Configure size to match origin view
focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

// Attach at the bottom of the origin view
focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
```

Make sure constraints are added after the view has been added to the View
Controller's view hierarchy.

Here is how our new focus guide would look, if it was visible on screen (green rectangle):

![UIFocusGuide](/media/articles/tvos-uifocusguide/03-focus-guide.png)
*Focus guide attached to the [Constructors' Championship] button.*

Now, when our user swipes down from the [Constructors' Championship] button,
they will be directed to the next season button [2018].

## Back from 2018 to Constructors' Championship

At this point, the user can navigate from the top three buttons to the bottom-left
one by swiping down.

Interestingly, because the previous season button [2016] on the bottom-right of
the screen is vertically aligned with the next season one [2018], our users
can move focus to it by swiping right. Swiping left would bring the focus back
to the next season button [2018].

![UIFocusGuide](/media/articles/tvos-uifocusguide/04-stuck-again.png)
*User is now stuck on the bottom area of the screen.*

The focus engine needs our help to determine how to move the focus back from
the next season button [2018] to the [Constructors' Championship] button.

As before, we will add a new focus guide, this time on top of the next
season button.

```swift
let origin = nextSeasonButton // 2018 button
let destination = constructorsStandingsButton
let focusGuide = UIFocusGuide()
view.addLayoutGuide(focusGuide)

// Indicate where to transfer focus
focusGuide.preferredFocusEnvironments = [destination]

// Configure size to match origin view
focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

// Attach at the top of the origin view
focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
```

This is how the focus guide would look, if it was visible on screen:

![UIFocusGuide](/media/articles/tvos-uifocusguide/05-second-guide.png)
*Second focus guide attached to the top of the next season button [2008] (bottom-left).*

At this point, our users will be able to navigate from the next season button
[2018] back to the [Constructors' Championship] button. And with that, while
not perfect, all buttons on the screen are now accessible by the focus engine.

We will improve the navigation later, by adding more focus guides.

## DRY Code

Take a look at the code again. Probably you already noticed the code used to
create the second focus guide was pretty much carbon copy from the code we used
to add the first focus guide.

We could easily make it a function. Better, yet, an _extension_! DRY! Yes!

There are three things we need:
1. An origin `UIView`
1. A destination `UIView`
1. Some way to indicate the swipe direction (up, down, left, right),
    so we can attach the focus guide to the correct edge of the origin view.

For the swipe direction, we could create our own `enum`, or use an existing one
like `UIRectEdge` as follows.

```swift
extension UIViewController {
    func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge) -> UIFocusGuide {
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = [destination]

        // Configure size to match origin view
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom: // swipe down
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top: // swipe up
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left: // swipe left
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right: // swipe right
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            // Not supported :(
            break
        }

        return focusGuide
    }
}
```

With this extension, we can now add focus guides in our view controller with
minimal code:

```swift
addFocusGuide(from: constructorsStandingsButton, to: nextSeasonButton, direction: .bottom)
addFocusGuide(from: nextSeasonButton, to: constructorsStandingsButton, direction: .top)
```

🤩🤩🤩

# How Many Focus Guides?

Our goal is for navigation to feel natural. This means that users should be
able to swipe vertically, horizontally and diagonally, to navigate between our
user interface elements.

Users will expect that swiping would move focus to the _nearest_ element in that
direction.

For example, users of this app swiping right from any button on the top menu,
will expect the previous season [2016] button to be focused.

We could achieve this by adding three focus guides, one for each menu button.
A better solution however, would be to add a single focus guide to the right
of the menu **stack view**. This focus guide will capture focus transfers from
**any** of the buttons inside it (including any new buttons added in the future).

```swift
addFocusGuide(from: menuStackView, to: previousSeasonButton, direction: .right) // yay!
```

![UIFocusGuide](/media/articles/tvos-uifocusguide/06-stack-view-guide.png)
*Third focus guide attached to the right of the menu stack view.*

The production version of this app has a total of seven focus guides on this screen:

```swift
func configureFocusLayout() {
    // From stack buttons
    addFocusGuide(from: lastMenuButton, to: [nextSeasonButton, previousSeasonButton], direction: .bottom)
    addFocusGuide(from: menuStackView, to: nextSeasonButton, direction: .left)
    addFocusGuide(from: menuStackView, to: previousSeasonButton, direction: .right)

    // From next season button
    addFocusGuide(from: nextSeasonButton, to: lastMenuButton, direction: .top)
    addFocusGuide(from: nextSeasonButton, to: [previousSeasonButton, lastMenuButton], direction: .right)

    // From previous season button
    addFocusGuide(from: previousSeasonButton, to: lastMenuButton, direction: .top)
    addFocusGuide(from: previousSeasonButton, to: [nextSeasonButton, lastMenuButton], direction: .left)
}
```

![UIFocusGuide](/media/articles/tvos-uifocusguide/07-all-guides.png)
*Seven focus guides added to enhance navigation focus transitions.*

Notice that some of the guides have two destinations instead of one. This is
because the focus engine will automatically pick the next destination in the list
if the previous one is not available (the view is hidden, for instance).

Implementing these two methods in our extension facilitates that:

```swift
func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge) -> UIFocusGuide
func addFocusGuide(from origin: UIView, to destinations: [UIView], direction: UIRectEdge) -> UIFocusGuide
```

# Visualizing Focus Guides

> An image is worth a thousand words.

Sometimes we need to see it, for us to understand how it works.

Turns out `UIFocusGuide` are truly invisible and there is no way to render them
on screen. However, we can use their layout frame to render a
debugging view on the same location.

Our `FocusGuideDebugView` will be constructed from a `UIFocusGuide` as follows:

```swift
class FocusGuideDebugView: UIView {

    init(focusGuide: UIFocusGuide) {
        super.init(frame: focusGuide.layoutFrame)
        backgroundColor = UIColor.green.withAlphaComponent(0.15)
        layer.borderColor = UIColor.green.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
```

We will update our extension methods to take a `debugMode` parameter (defaulting it to `false`).

```swift
func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide
func addFocusGuide(from origin: UIView, to destinations: [UIView], direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide
```

Before returning, we check if `debugMode` is on, to add the debugging view.

```swift
if debugMode {
    view.addSubview(FocusGuideDebugView(focusGuide: focusGuide))
}
```

We can now update our configuration code to enable `debugMode`:

```swift
addFocusGuide(from: menuStackView, to: nextSeasonButton, direction: .left, debugMode: true)
addFocusGuide(from: menuStackView, to: previousSeasonButton, direction: .right, debugMode: true)
```

## Frames

Since we are using frames for our debugging views, we want to call the
configuration code after auto-layout has finished adjusting the screen.
We set a flag to prevent multiple calls.

```swift
override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    if isFocusLayoutConfigured == false {
        configureFocusLayout()
        isFocusLayoutConfigured = true
    }
}
```

Alternatively, the debugging views could be anchored in the same way as we did
with the focus guides, letting auto-layout position them properly on screen.

# Full View Controller Extension Source Code for UIFocusGuide

The following is the production ready code used on this application:

```swift
extension UIViewController {
    @discardableResult
    func addFocusGuide(from origin: UIView, to destination: UIView, direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        return addFocusGuide(from: origin, to: [destination], direction: direction, debugMode: debugMode)
    }

    @discardableResult
    func addFocusGuide(from origin: UIView, to destinations: [UIView], direction: UIRectEdge, debugMode: Bool = false) -> UIFocusGuide {
        let focusGuide = UIFocusGuide()
        view.addLayoutGuide(focusGuide)
        focusGuide.preferredFocusEnvironments = destinations
        focusGuide.widthAnchor.constraint(equalTo: origin.widthAnchor).isActive = true
        focusGuide.heightAnchor.constraint(equalTo: origin.heightAnchor).isActive = true

        switch direction {
        case .bottom:
            focusGuide.topAnchor.constraint(equalTo: origin.bottomAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .top:
            focusGuide.bottomAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .left:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.rightAnchor.constraint(equalTo: origin.leftAnchor).isActive = true
        case .right:
            focusGuide.topAnchor.constraint(equalTo: origin.topAnchor).isActive = true
            focusGuide.leftAnchor.constraint(equalTo: origin.rightAnchor).isActive = true
        default:
            // Not supported :(
            break
        }

        if debugMode {
            view.addSubview(FocusGuideDebugView(focusGuide: focusGuide))
        }

        return focusGuide
    }
}

class FocusGuideDebugView: UIView {

    init(focusGuide: UIFocusGuide) {
        super.init(frame: focusGuide.layoutFrame)
        backgroundColor = UIColor.green.withAlphaComponent(0.15)
        layer.borderColor = UIColor.green.withAlphaComponent(0.3).cgColor
        layer.borderWidth = 1
    }

    required init?(coder aDecoder: NSCoder) {
        return nil
    }
}
```

---

# Conclusion

`UIFocusGuide`s could be though as invisible `UIView`s that, when focused,
automatically transfer their focus to a given destination.

Being able to "see" them on screen is, without any doubt, extremely helpful.

### Attributions

I got the idea of drawing `UIFocusGuide` on screen from this great article by
Eric Dolecki [tvOS UIFocusGuide Demystified](http://blog.ericd.net/2017/05/10/tvos-uifocusguide-demystified).
