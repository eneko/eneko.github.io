---
layout: page
title: Grand Prix Stats AppleTV App
permalink: /projects/grand-prix-stats/
---



![](/media/grand-prix-stats/screenshot-1.png)
*Application icon and Top Shelf image*

![](/media/grand-prix-stats/screenshot-4.png)
*Season Calendar*

![](/media/grand-prix-stats/screenshot-3.png)
*Race Menu*

![](/media/grand-prix-stats/screenshot-6.png)
*Qualifying Results*

![](/media/grand-prix-stats/screenshot-7.png)
*Starting Grid*

![](/media/grand-prix-stats/screenshot-5.png)
*Race Results*

![](/media/grand-prix-stats/screenshot-8.png)
*Race Track Layout*

# Behind the Scenes

{% highlight swift %}
struct Circuit {

    var circuitId: String
    var name: String
    var url: String
    var location: Location

    init(json: JSON) {
        circuitId = json["circuitId"].stringValue
        url = json["url"].stringValue
        name = json["circuitName"].stringValue
        location = Location(json: json["Location"])
    }

}
{% endhighlight %}
