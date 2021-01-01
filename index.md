---
layout: page
title: An Over-Engineered Blog
permalink: /
desc: Hi, I am Eneko Alonso, a software engineer specialized in Swift, with many years of experience developing apps for iOS and tvOS. I live in San Luis Obispo, California.
---

[![Blog Architecture](https://user-images.githubusercontent.com/32922/103234437-88d7db80-48f4-11eb-8902-927f015028e5.png)](https://user-images.githubusercontent.com/32922/103234437-88d7db80-48f4-11eb-8902-927f015028e5.png)
<em>Current blog architecture</em>

### Latest Articles

<div class="article-list">
{% for post in site.posts limit:15 %}
  <div class="article-list-item">
    <p class="preview"><a href="{{ post.url | prepend: site.baseurl }}"><img src="{{post.image}}" /></a></p>
    <p class="title"><a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a></p>
    <p class="excerpt">{{ post.excerpt | strip_html | truncate: 140 }}</p>
  </div>
{% endfor %}
</div>

More: [All Articles](/articles) · [RSS Feed <img class="feed-icon" src="/media/feed-icon.svg">]({{ "/feed.xml" | prepend: site.baseurl }})


### Projects

- [SourceDocs](https://github.com/eneko/SourceDocs), a documentation generator for Swift projects.
- [MarkdownGenerator](https://github.com/eneko/MarkdownGenerator), a tiny Swift framework to generate markdown.
- [Ninety-Nine Swift Problems](/projects/99-swift-problems), educational exercises to be solved while learning Swift.
- [Ninety-Nine Swift Solutions](https://github.com/eneko/Ninety-Nine-Swift-Solutions), community solutions for the Ninety-Nine Swift Problems .
- [Grand Prix Stats](/projects/grand-prix-stats), TV application for Formula 1® fans.
- [No Dice!](https://itunes.apple.com/us/app/no-dice/id1448825450?ls=1&mt=8), iOS application for Catan players.

### Infographics & Visualizations

- [Formula One® Constructor Victories Year by Year]( /infographics/f1/constructor-wins-by-year)

### About Me

I am a software engineer, currently working full-time
at [Mindbody](https://mindbody.io) in [San Luis Obispo, California](http://visitslo.com).
There, I get to work with very talented people, crafting beautiful mobile
applications for our clients and their customers.

Here are some of my technical skills:

- Swift on iOS, tvOS, macOS & Linux (AWS Lambda 🎉)
- REST API design & integrations
- Database modeling (RDBMS and No-SQL)


Follow me on Twitter at [@eneko](https://twitter.com/eneko), take a look at
[my profile on Stack Overflow](https://stackoverflow.com/users/422288/eneko-alonso)
or check out my [open source contributions on GitHub](https://github.com/eneko).
