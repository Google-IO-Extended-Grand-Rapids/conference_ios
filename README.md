# conference_ios
Repo for the iOS application for the conference app

# Development Environment
* Xcode Version 6.1.1 (6A2008a) or higher
* [CocoaPods](http://cocoapods.org/)

## CocoaPods
* Install CocoaPods following the normal install, then update to latest version (0.36.0.rc.1):
```
$ sudo gem install cocoapods --pre
```
* You can interact with CocoaPods in the /conference_ios/ConferenceApp directory
```
$ cd /ConferenceApp
$ pod setup
```
* If you need to add another dependency, update the Podfile and run:
```
$ pod install
```

## Open the XCWorkspace File!
* When you open this project in Xcode, make sure to open the file ConferenceApp.xcworkspace and not the xcodeproj in order for CocoaPods to link to the project via Frameworks
