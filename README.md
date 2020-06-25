# Cities of the world
Square1 work application

## Overview
Cities of the world it's an iOS app for search and visualize cities information. It allows the users to search cities by their names and show their information in a list or map view.

App requirements:
1. Clean presentation.
2. Use infinite scroll for results list pagination.
3. Filter results by city name using a search field.
4. Implement local cache of results.
5. Toggle results between list and map view.

## Technical specifications
Cities of the world was developed for iOS 13.0+ with Swift 5 and XCode. 

The app was designed with MVVM (Model-View-ViewModel), coordinators and repositories patterns. MVVM was used to control view logic and flow because it allows us better separation between view presentation layer, view control layer and data layer. Coordinators pattern was used to control app routing becasue its more scalable and merge conflicts tolerable than Storyboards and SwiftUI it's too new to implement it on a production application. Also, repositories patterns was used to abstract data source decision between cache and API sources.

I used Realm to store cache because it's very fast and more user friendly than CoreData. I created two realm databases: Cities-memory and Cities-storage. Cities-memory was used for fatser queries because use an in-memory database to avoid I/O operations. When the user search a city, app fetch results from cache and check if they are still valid (1 hour TTL), if not, new results are fetched from API and stored on both databases.