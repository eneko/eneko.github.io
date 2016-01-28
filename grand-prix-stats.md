---
layout: page
title: Grand Prix Stats AppleTV App
permalink: /grand-prix-stats/
---

![Application icon and Top Shelf image - Grand Prix Stats](/media/grand-prix-stats/screenshot-1.png)
*Application icon and Top Shelf image*

Grand Prix Stats is an Apple TV application that provides information about
the Formula 1® driver and constructor championships.

The application provides the following information:

- Season Navigation from 2000-2015
- Season Race Calendar
    - Race Results
    - Qualifying Results
    - Starting Grid
    - Fastest Laps
    - Race Track Layout
- Season Driver Championship Standings
- Season Constructor Championship Standings


### Season Navigation

Grand Prix Stats includes information from all seasons from year 2000 to
year 2015.  Navigation between seasons is done using a previous/next
season format, where the user can quickly move from one season to another.

![Season Navigation Menu - Grand Prix Stats](/media/grand-prix-stats/screenshot-9.png)
*Season Navigation Menu*

### Season Race Calendar

![Season Calendar - Grand Prix Stats](/media/grand-prix-stats/screenshot-4.png)
*Season Calendar*

# Race Menu

![Race Menu - 2015 United States Grand Prix - Grand Prix Stats](/media/grand-prix-stats/screenshot-3.png)
*Race Menu - 2015 United States Grand Prix*

### Race Results

![Race Results - Grand Prix Stats](/media/grand-prix-stats/screenshot-5.png)
*Race Results*

### Qualifying Results

![Qualifying Results - Grand Prix Stats](/media/grand-prix-stats/screenshot-6.png)
*Qualifying Results*

### Starting Grid

![Starting Grid - Grand Prix Stats](/media/grand-prix-stats/screenshot-7.png)
*Starting Grid*

### Fastest Laps

![Fastest Laps - Grand Prix Stats](/media/grand-prix-stats/screenshot-10.png)
*Fastest Laps*

### Race Track Layout

![Race Track Layout - Grand Prix Stats](/media/grand-prix-stats/screenshot-8.png)
*Race Track Layout*

### Season Driver Championship Standings

![Driver Championship Standings - Grand Prix Stats](/media/grand-prix-stats/screenshot-11.png)
*Driver Championship Standings*

### Season Constructor Championship Standings

![Constructor Championship Standings - Grand Prix Stats](/media/grand-prix-stats/screenshot-12.png)
*Constructor Championship Standings*


#### Installation

Open the App Store application on your Apple TV and search for
"Grand Prix Stats".  The application should appear on the list.

# Behind the Scenes

```swift
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
```
