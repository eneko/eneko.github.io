---
layout: post
title: Calculating percentages of translated text on a website using a Multi-Threaded Crawler and a Naive Bayes Classifier written in Swift
date: 2016-02-12
desc: I wrote a crawler in Swift to detect the percentage of text translated on a website.
keywords: swift, http, crawl, detection, language, localization, translation, content
image: /media/articles/language-detection/xcode-worker-threads.png
---

A few years back we built Applied Materials corporate website.
This website was localized to **5 different languages**:
English, Japanese, Korean, Chinese (both simplified and traditional).
Non-English pages were set to default to English if a translation didn't exist
for the selected language.

Last week our client asked us if we could **put together a report indicating
the amount of text pending to be translated for each of the languages
supported by the website**.

Basically, if the user selected Japanese, the client wanted to know how many
pages where still showing English content. Furthermore, the client would be
very pleased if they knew how much of each page was translated
(none, half, all?).

Some pages where "completely" translated:

![Translated Product](/media/articles/language-detection/product-translated.png)
*A "fully" translated product page*

Some pages where not translated at all:

![Non-Translated Product](/media/articles/language-detection/product-non-translated.png)
*A non-translated product page*

Other pages had a mix of translated content and non-translated English content:

![Half Translated Page](/media/articles/language-detection/semi-translated-page.png)
*Half translated page*

* * *

## Solving the Problem
Since the website is pretty large, I thought it would be nice to write a
crawler and analyze the text extracted from the website to detect the languages
using a language detection algorithm.

The job could be split in three major tasks:

- Crawl (to navigate each page of the site)
- Text Extraction (to get relevant copy from the HTML)
- Language Detection (to provide the results we needed)

## Crawl
I wanted the crawler to be fast and to focus first on the top level pages. To
make it fast, I wrote a multi-threaded application to process
many pages in parallel. To focus on the top level pages, I used a
[Minimum Priority Queue](https://github.com/eneko/DSAA/blob/master/Sources/DataStructures/PriorityQueue.swift)
with the priority based on the length of the url.

### Worker Threads
Used to `GCD` and `NSOperationQueue`, it had been a while since I last wrote a
program with a thread pool of worker threads. I wondered about
using `NSThread` but I decided to give `dispatch_group` a shot.

The workers wait for a job until they get one from the queue. The process stops
when the queue is completely empty and no worker is actively processing a page.
In my tests, it seems that 10 to 20 threads worked best.

![Xcode - Crawler Worker Threads](/media/articles/language-detection/xcode-worker-threads.png)
*Xcode CPU view shows active worker threads*

![Xcode - Energy Impact](/media/articles/language-detection/energy-impact.png)
*Squeezing all the juice from my laptop*


### Priority Queue
In an attempt to do a breadth-first crawl, I used a Minimum Priority Queue with
the priority based on the length of the url. Shorter urls would then be
processed first, while longer urls will be left for later processing.

I wrote a concurrent-ready wrapper for the
[Priority Queue](https://github.com/eneko/DSAA/blob/master/Sources/DataStructures/PriorityQueue.swift).
Using `NSLock` it
will guarantee safe access to add and remove items to and from the queue. This
queue will also keep track of previously processed urls, to avoid adding
duplicates.

Interestingly, Swift `defer` can remove the lock after returning the result. I
found that pretty sweet (see `removeJob()` and `isEmpty()` methods below).

~~~swift
class CrawlQueue {

    let queueLock = NSLock()
    var queue: PriorityQueue<CrawlJob>
    var uniqueURLs: [String]

    init() {
        queue = PriorityQueue<CrawlJob>(order: .Min)
        uniqueURLs = []
    }

    func addJob(job: CrawlJob) {
        queueLock.lock()
        if uniqueURLs.contains(job.url.absoluteString) == false {
            uniqueURLs.append(job.url.absoluteString)
            queue.add(job)
        }
        queueLock.unlock()
    }

    func removeJob() -> CrawlJob? {
        queueLock.lock()
        defer { queueLock.unlock() }
        return queue.remove()
    }

    func isEmpty() -> Bool {
        queueLock.lock()
        defer { queueLock.unlock() }
        return queue.isEmpty()
    }

}
~~~

## Text Extraction

### HTML Tags
After retrieving the HTML content of a page, we had to extract the text.
Instead of checking the entire HTML, I focused on
`<h1>`, `<h2>`, `<h3>`, `<h4>` and, most importantly, `<p>` tags. I considered
checking also for links (`<a>` tags) but finally decided to not include them
as most of them where related to navigation.

### Regular Expressions
While [HTML cannot be parsed with regular expressions](http://stackoverflow.com/a/1732454/422288)
(thanks for the reminder, [Vincent](https://github.com/sdobz)),
I found that for the job at hand, regular expressions where good enough
(thank you for the assistance, [Kevin Strong](https://github.com/kmstrong)).

When extracting text from the HTML, I noticed that
extracting substrings from a `NSString` was much, much, faster than doing it
from a Swift `String` (maybe because of the `NSRange` to `Range` conversion).

`NSString` version:

~~~swift
func matchesForRegexInText(regex: String, text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
        let range = NSMakeRange(0, text.characters.count)
        let results = regex.matchesInString(text, options: [], range: range)
        let nsString = text as NSString
        let urls: [String] = results.map { result in
            return nsString.substringWithRange(result.rangeAtIndex(1))
        }
        return urls
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
~~~

`String` version (much slower):

~~~swift
func matchesForRegexInText(regex: String, text: String) -> [String] {
    do {
        let regex = try NSRegularExpression(pattern: regex, options: [.CaseInsensitive])
        let range = NSMakeRange(0, text.characters.count)
        let results = regex.matchesInString(text, options: [], range: range)
        let urls: [String] = results.map { result in
            let start = text.startIndex.advancedBy(result.rangeAtIndex(1).location)
            let end = start.advancedBy(result.rangeAtIndex(1).length)
            return text.substringWithRange(Range<String.Index>(start: start, end: end))
        }
        return urls
    } catch let error as NSError {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}
~~~

Link extraction:

~~~swift
matchesForRegexInText("href=\"([^\"]*?)\"", text: html)
~~~

Text block extraction:

~~~swift
matchesForRegexInText("<\($0).*?>(.*?)</\($0)>", text: html)
~~~

## Language Detection

### Naive Bayes Classifier
I looked online for different language detection libraries. I found this
[Parsimmon Naive Bayes Classifier](https://github.com/ayanonagon/Parsimmon#naive-bayes-classifier)
written by [Ayaka Nonaka](https://github.com/ayanonagon)
and I was very pleased with it.

![Parsimmon by Ayaka Nonaka](/media/articles/language-detection/parsimmon.png)
*Parsimmon by Ayaka Nonaka*

[Naive Bayes Classifiers](https://en.wikipedia.org/wiki/Naive_Bayes_classifier)
work not by detecting the actual language of a piece
of text, but instead by matching it against some text samples previously
provided to *train* the classifier.

~~~swift
let classifier = NaiveBayesClassifier()
classifier.trainWithText("Investor Relations", category: "en")
classifier.trainWithText("Emerging Technologies and Products", category: "en")
classifier.trainWithText("製品・技術", category: "jp")
classifier.trainWithText("グローバルサービス", category: "jp")

classifier.classify("Investor") // "en"
classifier.classify("技術") // "jp"
~~~

I had to *train* the classifier with many more text samples, but at the end it
turned out to be pretty accurate.

### Detecting Many Languages vs. Differentiating Between Two
At first I tried crawling all pages for all languages and have the classifier
discern among all 5 languages.  The results were not very accurate and it seemed
as if it was hard to tell apart the four asian languages.

To increase the accuracy, I ran the crawler separately, focusing only on one
language at a time (urls starting with `/ja` for example) and detecting if the
blocks of text were english or Japanese.

The results were so accurate I was thrilled.

## Generating Output
For the output I went for a CSV format, printed in the process output as the
workers processed every page. The output could be piped to a file from the
terminal or copied and pasted from the Xcode console into a text file.

From there, it will take no effort to import the CSV file into Google Docs.

![Output Report](/media/articles/language-detection/output-report.png)
*Output Report in Google Docs*

## Conclusion
Hope you enjoyed the reading as much as I enjoyed writing this crawler :)
