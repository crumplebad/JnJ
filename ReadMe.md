# JnJTracker

JnJTracker (JJT) a utility iOS app created for J&J Garage to keep track of testing devices. JJT works with and without internet connection. Offline line transactions are synced to the server, once network connection is established.

### Architecture
JJT uses a variation of MVC, somewhere between MVC and VIPER. VIPER was not implemented because of lack of time, not that VIPER takes a lot more time than MVC. I had so many new things to learn for this project, I wanted to maintain simplicity and did not want to spend time on things that were not required.

Some of the elements of VIPER used in this project are single responsibility and abstraction, which is explained as below. The project can be very easily refactored to confirm to VIPER architecture.
- DataManager: There is one app level Datamanager, which as the name suggests manages the data among service class, ReachabilityManager, DataModel and View Controllers. Realm DB can be switched to other DB with minimal changes to other classes. This can be refactored to screen specific DataManager to comply with VIPER.
- RestAPIService: This class is again an app-level class responsible to make all REST service calls. This class also can be refactored to be screen specific and in turn confirm with VIPER. This also makes it easier to switch Alamofire with other network libraries without affecting DataManager or View Controllers. 
- Entity Classs: JJT has only one entity class - 'Device' and corresponsding collection class 'Devices'. Since, Device class is sub-classed from Realm Object, its poses challenges with over-ridding the 'init' method. To overcome this challenge some of the initialization/parsing code is moved to the Devices class and RestAPIService class, which is not very elegant. This has to be refactored, as part of the next phase.

### Version
1.0.0

### Tech

JJT uses a number of open source projects to work properly:

* [Alamofire] - For making REST service calls.
* [SwiftyJSON] - For parsing JSON data received form the REST service
* [Realm] - For persisting data locally.
* [Carthage] - For dependency management.
* [Dillinger] - Online Mark Down editor to prepare ReadMe.md

### Installation/Run
JJT use iOS 9.3.1 SDK and Swift 2.2 
You need to install Carthage before compiling JJT

```sh
$ cd <to project folder>
$ carthage update --platform iOS
```
I used Carthage instead of CocoaPods for the simplicity and ease of use. Its very easy to replace Carthage by other dependency managers, unlike CocoaPods 
```
$ vi Cartfile
```

### Next Phase

This coding exercise has been a great opportunity to learn Swift, Realm, StoryBoards etc. At times it was frustrating to deal with Swift Optionals while parsing the JSON, which encouraged me to explore better solutions and that resulted in me using SwiftyJSON. I will continue to work on this and add a few enchancments.

- Refactor architecture to VIPER.
- Refactor entity and other classes.
- Add waiting screen, while network acitivty is in progress
- Switch Realm, with CoreData.
- Revist passing strong 'self' to Closures, which causes retain cycle. Play with [unowned self] instead of [weak self]
- Revisit error handling especial for Realm.


 [Alamofire]: <https://github.com/Alamofire/Alamofire>
 [SwiftyJSON]: <https://github.com/SwiftyJSON/SwiftyJSON>
 [Realm]: <https://realm.io>
 [Carthage]: <https://github.com/Carthage/Carthage>
 [Dillinger]: <http://dillinger.io>