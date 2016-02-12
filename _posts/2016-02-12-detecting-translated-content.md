---
layout: post
title: Calculating percentages of translated text on a website using a Multi-Threaded Crawler and a Naive Bayes Classifier written in Swift
date: 2016-02-12
desc: I wrote a crawler in Swift to detect the percentage of text translated on a website.
keywords: swift, http, crawl, detection, language, localization, translation, content
image: /media/articles/language-detection/xcode-worker-threads.png
---

A few years back I worked on a project for Applied Materials where we built
their corporate website. This website was localized to **5 different languages**:
English, Japanese, Korean, Chinese (both simplified and traditional).
Non-English pages would default to English if a translation didn't exist for
the selected language.

Last week I was asked if I could **put together a report indicating, for each of
the languages supported by the website, the amount of text pending to be
translated**.

Basically, if the user selected Japanese, the client wanted to know how many
pages where still in English. Furthermore, the client would be very pleased if
they could know how many pages contained some Japanese, but were not fully
translated.

Since the website is pretty large, I thought it would be nice to write a
crawler and analyze the text extracted from the website to detect the language
using some sort of language detection algorithm.

The job could be split in three major tasks:

- Crawling (to navigate each page of the site)
- Text Extraction (to get relevant copy from the HTML)
- Language Detection (to provide the results we needed)

* * *

## Crawling
I wanted my crawler to be fast and to focus first on the top level pages. To
achieve both of those goals, I used multiple threads to process many pages in
parallel and used a priority queue to track the urls to process.

### Worker Threads
To make it fast, I made it multi-threaded, with a worker pool of configurable
size. It seems that 10 to 20 threads worked best. I tried but couldn't get it
to run more than 64 threads, maybe because a limitation of `dispatch_group`.

![Xcode - Crawler Worker Threads](/media/articles/language-detection/xcode-worker-threads.png)
*Xcode CPU view shows active worker threads*


### Priority Queue
, in an
attempt to do a breadth-first crawl

## Text Extraction
Paragraphs, titles and links
Regular expressions

## Language Detection
### Naive Bayes Classifier
https://en.wikipedia.org/wiki/Naive_Bayes_classifier
Bayes theorem
[Parsimmon Naive Bayes Classifier](https://github.com/ayanonagon/Parsimmon#naive-bayes-classifier) written by [Ayaka Nonaka](https://github.com/ayanonagon) (follow [Ayaka Nonaka on Twitter](http://twitter.com/ayanonagon))

### Detecting many languages vs differentiating between two

## Generating Output
For the output I went for a CSV format, printed in the process output as the
workers processed every page. The output could be piped to a file from the
terminal or copied and pasted from the Xcode console into a text file.

From there, it will take no effort to import the CSV file into Google Docs.
