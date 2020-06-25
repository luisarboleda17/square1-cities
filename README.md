# Cities of the world
As part of the Square1 work application, I have developed an iOS app based on the requirements provided for City of the World app.

## Overview
Cities of the world it's an iOS app for search and visualize cities information. It allows the users to search cities by their names and show their information in a list or map view.

App requirements:
1. Clean presentation.
2. Use infinite scroll for results list pagination.
3. Filter results by city name using a search field.
4. Implement local cache of results.
5. Toggle results between list and map view.

## Technical specifications
Cities of the world was developed for iOS 13.0+ devices with Swift 5 and XCode. 

The app was designed with **MVVM (Model-View-ViewModel), coordinators, and repositories patterns**. MVVM was used to control view logic and flow because it allows us the better separation between view presentation layer, view control layer, and the data layer. Coordinators pattern was used to control app routing because it's more scalable and merge conflicts tolerable than Storyboards and SwiftUI it's too new to implement it on a production application. Also, repositories patterns were used to abstract data source decisions between cache and API sources.

I used Realm to store cache because it's very fast and more user friendly than CoreData. I created two realm databases: Cities-memory and Cities-storage. Cities-memory was used for faster queries because it use an in-memory database to avoid I/O operations. When the user searches a city, app fetch results from the cache and check if they are still valid (1 hour TTL), if not, new results are fetched from API and stored on both databases.

Libraries:
- [Alamofire](https://github.com/Alamofire/Alamofire): A HTTP networking library that simplifies networking tasks.
- [RealmSwift](https://realm.io/docs/swift/latest): A faster mobile database that simplifies data layer and persistence on mobile devices.
- [Maps SDK for iOS](https://developers.google.com/maps/documentation/ios-sdk/start): A maps library that provides an interface to add Google Maps' maps on iOS projects.

I have developed tests for the core sections of the app: API and Cache Manager, to make sure that the info retrieved from the different data sources are consistent with what we expect.

## Getting started

**Prerequisites:**
- macOS computer.
- XCode app installed.
- A Google account.

**Google Cloud project:**

1. Sign-in into your Google Account ([Google Cloud Console](https://console.cloud.google.com/))
2. Create a project ([Create and manage projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects))
3. Enable billing on the project ([Google Cloud Billing](https://console.cloud.google.com/project/_/billing/enable?redirect=https://developers.google.com/maps/documentation/ios-sdk/start?dialogOnLoad%3Dbilling-enabled))
4. Enable Maps SDK for iOS ([Maps SDK for iOS](https://console.cloud.google.com/apis/library/maps-ios-backend.googleapis.com))
5. Create and restrict an Google Maps API Key ([Get the API key](https://developers.google.com/maps/documentation/ios-sdk/get-api-key#get_key))
6. Copy the API key on a safe place. We will use it later.

**Configure XCode project:**
1. Clone this repo `git clone https://github.com/luisarboleda17/square1-cities`.
2. Open `cities of the world.xcworkspace` with XCode.
3. Open the project information and under targets select _cities of the world_.
4. Select your team.
4. Under the tab Signing & Capabilities change the Bundle identifier to what you want (You can add a random number at the end) and wait until Xcode manage signing.
2. Create a `APIKeys.swift` file at root of your XCode project.
3. Add `let GOOGLE_MAPS_API_KEY = "<YOUR_API_KEY>"` to the file created reeplacing <YOUR_API_KEY> with your previously created Google Maps key.
4. Select the device (iPhone or simulator) where you want to run the app.
5. Select Product > Run from the top toolbar.
6. Wait until XCode installs the app on your device.

## Credits
Cities of the world was developed and maintained by [Luis Arboleda](mailto://hello@larboleda.io). You can send me an email at [hello@larboleda.io](mailto://hello@larboleda.io), follow me on Twitter at [@luis_arboleda17](https://twitter.com/luis_arboleda17) or LinkedIn at [Luis Arboleda](https://www.linkedin.com/in/luis-arboleda/) to stay in touch.