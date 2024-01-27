<div align="center">
  <h1 align="center">SAT Scores App</h1>
  <h3 align="center">iOS take home assignment built using SwiftUI</h3>
  <a href="https://github.com/jdpaul123/SATScores/tree/main">
    <img src="https://github.com/jdpaul123/SATScores/blob/main/SATScores/Assets/Assets.xcassets/SATLogo.imageset/SATLogo.png" alt="Logo" width="200">
  </a>
</div>

<br>
<div align="center">
  <img src="https://github.com/jdpaul123/SATScores/blob/main/Screenshots/SchoolsList.png" alt="Schools List View" width="200"/>
  <img src="https://github.com/jdpaul123/SATScores/blob/main/Screenshots/SchoolDetailViewWithSATScores.png" alt="Schools Detail View" width="200"/>
</div>

<br>
Hi,
<br><br>
  &emsp; I'm excited to submit and share my iOS Coding Challenge project for an iOS position with Adidev Technologies. I have had a great time considering the architecture, testability, and UI of this app as I planned and built it. If you have any questions about my thought process, code, or design please do not hesitate to contact me. Thank you for this opportunity!
<br><br>
Best,
<br>
JD Paul

## Contact information
* (650)619-6984
* jdpaul123@gmail.com

## Usage
1. Download the .zip for this repo.
2. Open the SATScores.xcodeproj file in Xcode.
3. Press Cmd+R to run the project in a iPhone or iPad simulator or physical device.

## Software and Language Versions
* Xcode: 15.2
* Swift: 5.9
* iOS target version: 17.2

## Features meeting requirements
* The app gets data from the two endpoints outlined in the project specification to get the list of schools and their SAT score data and then, when a user clicks on a school and views their detial screen the user sees their average SAT scores and another API call occurs to get and display more information about the school:
https://data.cityofnewyork.us/resource/s3k6-pzi2.json
https://data.cityofnewyork.us/resource/f9bf-2cp4.json
* The list of schools are displayed in the SchoolLListScreen.
* The data pertaining to a schools average SAT Scores is displayed in the SchoolDetailScreen.
* The app only utilizes first-party frameworks that come with Xcode. No packages were used to aid development.

## Features exceeding requirements
### Architecture
* The app's architecture follows MVVM principles.
* The app utilizes principles of dependency injection avoiding hidden dependencies by passing them in to class/struct initializers and function parameters.
* There is a network and data service to seperate concerns between parts of the app. It decouples the view from the network and data logic making the app more maintainable and testable.
* The service classes conform to protocols in order to allow for the creation of mock versions when unit testing.
* The views utilize composable SwiftUI views to modularize the parts that are used to build each screen. This allows views such as the Loading View to be used on both the School List Screen and the School Detail Screen.
* The Data Service is not completely necessary as I do not manipulate the data that I get from the REST API, but if I needed to clean up the data in any way that is where I would do it. The View Models only access the Data Service rather than directly accessing the Network Service. This also allows for better unit testing where the Network Service can be mocked and return local data rather than actually interacting with the back end.

### Testing
* To view testing functions I have created please review the Network tests in my Fetch Desserts repository at https://github.com/jdpaul123/Desserts/blob/main/DessertsTests/NetworkServiceTests/NetworkServiceTests.swift . The project is very similar to this one.
* Had I had more time for this project I would have implimented tests for the SAT Scores app too

### Future considerations for testing
* Tests can be expanded to the other services and view models.
* Views can be tested using snapshot testing.
* The Injector class can be built out further to accomidate injecting mock versions of dependencies for cleaner testing.
* The Injector class can be used to accomidate SwiftUI Previews with mock services and local data to avoid using the network and isolate the view that is being previewed.

### User Interface
* Search Bar: There is a search bar on the SchoolListScreen to allow for quicker access when the user already knows what school they want to find.
* Pagination: The list of schools shows the first 50 schools in the database. Once you scroll to the bottom of the view the next 50 schools appear and so on using a limit of 50 and an offset value to keep track of what data to load.
* Error Banner Modifier: There is an error banner modifier to show an error banner over the current view with a message about the error any time there is an error in the app (seen in the middle image below).

There are 3 possible screen states as data is loaded and formatted:
1. Loading state which animates the app icon as a loading indicator
2. Failed state which displays an error banner when the app fails to get the data and allows the user to pull-to-refresh the data. This would be useful if the user is not connected to internet then connects to the internet then pulls to refresh the data.
3. Success state which shows the data (ie. the School List Screen or School Detail Screen)

<div align="center">
  <p float="left">
    <img src="https://github.com/jdpaul123/SATScores/blob/main/Screenshots/LoadingAnimation.png" alt="Loading State with SAT icon" width="200"/>
    <img src="https://github.com/jdpaul123/SATScores/blob/main/Screenshots/LoadingErrorViewWithBanner.png" alt="Failed State with Error Banner" width="200"/>
    <img src="https://github.com/jdpaul123/SATScores/blob/main/Screenshots/SchoolsList.png" alt="Success State for the School List Screen" width="200"/>
  </p>
</div>
