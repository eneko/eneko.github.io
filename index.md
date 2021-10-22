---
layout: page
title: An Over-Engineered Blog
permalink: /
desc: Hi, I am Eneko Alonso, a software engineer specialized in Swift, with many years of experience developing apps for iOS and tvOS. I live in San Luis Obispo, California.
---

[![Blog Architecture](https://user-images.githubusercontent.com/32922/103234437-88d7db80-48f4-11eb-8902-927f015028e5.png)](https://user-images.githubusercontent.com/32922/103234437-88d7db80-48f4-11eb-8902-927f015028e5.png)
<em>Current blog architecture</em>

### Latest Articles

<div class="articles">
{% for post in site.posts limit:5 %}
  <div class="article-item">
    <!-- p class="preview"><a href="{{ post.url | prepend: site.baseurl }}"><img src="{{post.image}}" /></a></p-->
    <p class="title"><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></p>
    <p class="excerpt">{{ post.excerpt | strip_html | truncate: 140 }}</p>
  </div>
{% endfor %}
</div>

More: [All Articles](/articles) · [RSS Feed <img class="feed-icon" src="/media/feed-icon.svg">]({{ "/feed.xml" | prepend: site.baseurl }})


### Projects

- [SourceDocs](https://github.com/eneko/SourceDocs), a documentation generator for Swift projects.
- [Ninety-Nine Swift Problems](/projects/99-swift-problems), educational exercises to be solved while learning Swift.
- [Ninety-Nine Swift Solutions](https://github.com/eneko/Ninety-Nine-Swift-Solutions), community solutions for the Ninety-Nine Swift Problems .
- [Grand Prix Stats](/projects/grand-prix-stats), TV application for Formula 1® fans.
- [No Dice!](https://itunes.apple.com/us/app/no-dice/id1448825450?ls=1&mt=8), iOS application for Catan players.

<!-- ### Infographics & Visualizations

- [Formula One® Constructor Victories Year by Year]( /infographics/f1/constructor-wins-by-year)
 -->

### About Me

I am a software engineer, living in [San Luis Obispo, California](http://visitslo.com). In my career, I've developed many kinds of software,
including UNIX services in C/C++, desktop applications for Windows, websites and web services in PHP and Ruby on Rails, and more. This last 
decade however my main focus has been iOS development, having released many different applications and features to the App Store.

Follow me on Twitter at [@eneko](https://twitter.com/eneko), take a look at
my [questions and answers on Stack Overflow](https://stackoverflow.com/users/422288/eneko-alonso)
or check out my [open source contributions on GitHub](https://github.com/eneko).
