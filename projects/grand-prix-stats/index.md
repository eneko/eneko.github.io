---
layout: page
permalink: /projects/grand-prix-stats/
title: Grand Prix Stats Apple TV App
desc: Grand Prix Stats is an application for Apple TV that provides information about the Formula 1® driver and constructor championships.
keywords: appletv, tv, app, formula1, formulaone, formula one, swift, tvos
image: /media/grand-prix-stats/screenshot.jpg
redirect_from:
    - /grand-prix-stats.html
---

![Application icon and Top Shelf image - Grand Prix Stats](/media/grand-prix-stats/screenshot-1.jpg)
*Application icon and Top Shelf image*

Grand Prix Stats is an application for [Apple TV](http://apple.com/tv) that
provides information about the Formula 1® driver and constructor championships.

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

* * *

### Season Navigation

Grand Prix Stats includes information from all seasons from year 2000 to
year 2015.  Navigation between seasons is done using a previous/next
season format, where the user can quickly move from one season to another.

![Season Navigation Menu - Grand Prix Stats](/media/grand-prix-stats/screenshot-9.jpg)
*Season Navigation Menu*

### Season Race Calendar

![Season Calendar - Grand Prix Stats](/media/grand-prix-stats/screenshot-4.jpg)
*Season Calendar*

### Race Menu

![Race Menu - 2015 United States Grand Prix - Grand Prix Stats](/media/grand-prix-stats/screenshot-3.jpg)
*Race Menu - 2015 United States Grand Prix*

### Race Results

![Race Results - Grand Prix Stats](/media/grand-prix-stats/screenshot-5.jpg)
*Race Results*

### Qualifying Results

![Qualifying Results - Grand Prix Stats](/media/grand-prix-stats/screenshot-6.jpg)
*Qualifying Results*

### Starting Grid

![Starting Grid - Grand Prix Stats](/media/grand-prix-stats/screenshot-7.jpg)
*Starting Grid*

### Fastest Laps

![Fastest Laps - Grand Prix Stats](/media/grand-prix-stats/screenshot-10.jpg)
*Fastest Laps*

### Race Track Layout

![Race Track Layout - Grand Prix Stats](/media/grand-prix-stats/screenshot-8.jpg)
*Race Track Layout*

### Season Driver's Championship Standings

![Driver's Championship Standings - Grand Prix Stats](/media/grand-prix-stats/screenshot-11.jpg)
*Driver's Championship Standings*

### Season Constructor's Championship Standings

![Constructor's Championship Standings - Grand Prix Stats](/media/grand-prix-stats/screenshot-12.jpg)
*Constructor's Championship Standings*


#### Installation

Open the App Store application on your Apple TV and search for
"Grand Prix Stats".  The application should appear on the list.

* * *


## Under the Hood

Grand Prix Stats was developed in:

- Xcode 7.x
- Swift 2

### Backend API

All data displayed by Grand Prix Stats is provided by the [Ergast Motor Racing Developer API](http://ergast.com/mrd/).

### Application Architecture

#### Backend Services

- CircuitService
- DriverService
- RaceService
- SeasonService
- StandingsService

~~~swift
class RaceService {

    static let sharedInstance = RaceService()

    func loadQualifyingResults(race: Race, callback: [QualifyingResult] -> Void) {
        JSONRequest.get("\(Ergast.baseURL)/\(race.season)/\(race.round)/qualifying.json?limit=30") { result in
            switch result {
            case .Success(let data):
                let json = JSON(data!)
                let results = json["MRData"]["RaceTable"]["Races"][0]["QualifyingResults"].arrayValue
                callback(results.map { QualifyingResult(json: $0) })
            case .Failure:
                callback([])
            }
        }
    }

    func loadRaceResults(race: Race, callback: [RaceResult] -> Void) {
        JSONRequest.get("\(Ergast.baseURL)/\(race.season)/\(race.round)/results.json?limit=30") { result in
            switch result {
            case .Success(let data):
                let json = JSON(data!)
                let results = json["MRData"]["RaceTable"]["Races"][0]["Results"].arrayValue
                callback(results.map { RaceResult(json: $0) })
            case .Failure:
                callback([])
            }
        }
    }

}
~~~

#### Data Structures

- Circuit
- Constructor
- ConstructorStanding
- Driver
- DriverStanding
- FastestLap
- Location
- QualifyingResult
- Race
- RaceResult
- Season
- SeasonStanding

~~~swift
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
~~~
