<p align="center">
  <img src="http://i.imgur.com/33kLEKI.png" alt="JHDropdown by Justin Hall"/>
</p>

<p align="center">
    <img src="https://img.shields.io/badge/platform-iOS%208%2B-blue.svg?style=flat" alt="Platform: iOS 8+"/>
    <a href="https://developer.apple.com/swift"><img src="https://img.shields.io/badge/swift2-compatible-4BC51D.svg?style=flat" alt="Language: Swift 2" /></a>
    <a href="https://cocoapods.org/pods/JHDropdown"><img src="https://cocoapod-badges.herokuapp.com/v/JHDropdown/badge.png" alt="CocoaPods compatible" /></a>
    <img src="http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat" alt="License: MIT" /> <br><br>
</p>


![](Animations/JHDropdownSuccess.gif)
![](Animations/JHDropdownError.gif)
![](Animations/JHDropdownCustom.gif)

## Installation
1. Manually add files to your XCode Project
2. Install using CocoaPods

JHDropdown is now available on [CocoaPods](http://cocoapods.org). Simply add the following to your project Podfile and install
```ruby
platform :ios, '8.0'
use_frameworks!

pod 'JHDropdown'
```

## Usage

Call Dropdown.show(_:) when you want to show the notification  

```swift
Dropdown.show("Set a message for the dropdown here", state: .Success, duration: 2.0, action: nil)
```

Customize the dropdown by using the .Custom DropdownState

```swift
let yourImage = UIImage(named: "yourimage")
let color = UIColor.anyColor()

Dropdown.show("Set a message for the dropdown here", state: .Custom(yourColor, yourImage), duration: 2.0, action: nil)
```

Run code after the animation for the dropdown is complete

```swift
Dropdown.show("Set a message for the dropdown here", state: .Error, duration: 2.0) {
  // this code will run once animation is complete
}
```

## 📝 To Do List 
* Add 3D animations to JHDropdown
* Add Carthage Installation support

## Author

Justin Hall: @ohthatsjhall

## License

JHDropdown is released under the MIT license. See LICENSE for details.

