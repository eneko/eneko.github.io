---
layout: page
title: An Over-Engineered Blog
permalink: /
desc: Hi, I am Eneko Alonso, a software engineer specialized in Swift, with many years of experience developing apps for iOS and tvOS. I live in San Luis Obispo, California.
---

![An Over-Engineered Blog](/media/blog-social.png)

### Projects

- [SourceDocs](https://github.com/eneko/SourceDocs), a documentation generator for Swift projects.
- [MarkdownGenerator](https://github.com/eneko/MarkdownGenerator), a tiny Swift framework to generate markdown.
- [Ninety-Nine Swift Problems](/projects/99-swift-problems), educational exercises to be solved while learning Swift.
- [Ninety-Nine Swift Solutions](https://github.com/eneko/Ninety-Nine-Swift-Solutions), community solutions for the Ninety-Nine Swift Problems .
- [Grand Prix Stats](/projects/grand-prix-stats), TV application for Formula 1® fans.
- [No Dice!](https://itunes.apple.com/us/app/no-dice/id1448825450?ls=1&mt=8), iOS application for Catan players.

### Articles

{% for post in site.posts %}
- [{{ post.title }}]({{ post.url | prepend: site.baseurl }}){% endfor %}

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
