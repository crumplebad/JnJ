# JnJTracker

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

### Architecture
JJT uses a variation of MVC, some where between MVC and VIPER. VIPER was not implemented because of lack of time, not that VIPER takes lot more time than MVC. I had so many new things to learn for this project, wanted to maintain simplicity.
Some of the elements of VIPER used in this project are single responsibility and abstraction, which is explained as below. The project can be very easily refactored to complete VIPER architecture.
- DataManager: There is one app level Datamanager, which as the name suggests manages the data among service class, DataModel and View Controllers. This can be refactored to screen specific DataManager to comply with VIPER.
- RestAPIService: This class is again app-level class responsible to make all REST service call. This class also can be refactored to be screen specific.
- Entity Classes: JJT has only one entity class - Device and corresponding collection class Devices. Since, Device class is sub-classed from Real Object, its poses challenges with over-ridding the init method. To over come this challenge some of the initialization/parsing code was moved to the Devices classes and RestAPIService class, which is not elegant. This has to be refactored, as part of next phase.  

> The overriding design goal for Markdown's


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

This coding exercise has been a great opportunity to learn Swift, Realm, StoryBoards etc. At times it was frustrating to deal with Swift Optionals while parsing the JSON, which encouraged me to explore better solutions and that resulted in me using SwiftyJSON. I will continue to work on this and add few enchantments.

- Refactor architecture to VIPER.
- Refactor entity and other classes.
- Add waiting screen, while network activity is in progress
- Switch Realm, with CoreData.
- Revisit passing strong 'self' to Closures, which causes retain cycle.
- Revisit error handling especial for Realm.


 [Alamofire]: <https://github.com/Alamofire/Alamofire>
 [SwiftyJSON]: <https://github.com/SwiftyJSON/SwiftyJSON>
 [Realm]: <https://realm.io>
 [Carthage]: <https://github.com/Carthage/Carthage>
 [Dillinger]: <http://dillinger.io>