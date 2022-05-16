# Google Maps Pick Place

> A pub.dev package to handle picking place from google map and use the picked data in the app.

- 🌟 Easy to use 🌟
- 🚀 Saves a lot of time 🚀
- ✨ It's like magic ✨

## Features

- Pick a place from google map
- Search for a specific
- Use the GPS and the current location
- New and customizable design
- Handle disconnected case
- handle refuse GPS access case

## Preview
![](preview.gif)

## Follow Me

<a href="https://www.linkedin.com/in/yousseufhebish/" target="_blank"><img src="https://www.edigitalagency.com.au/wp-content/uploads/Linkedin-logo-png.png" alt="Connect me On linked in" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

<a href="https://github.com/youssufhebish/" target="_blank"><img src="https://logos-world.net/wp-content/uploads/2020/11/GitHub-Emblem.png" alt="Follow me on github" style="height: 41px !important;width: 174px !important;box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;-webkit-box-shadow: 0px 3px 2px 0px rgba(190, 190, 190, 0.5) !important;" ></a>

## Getting Started

* Get an API key at <https://cloud.google.com/maps-platform/>.

* Enable Google Map SDK for each platform.
  * Go to [Google Developers Console](https://console.cloud.google.com/).
  * Choose the project that you want to enable Google Maps on.
  * Select the navigation menu and then select "Google Maps".
  * Select "APIs" under the Google Maps menu.
  * To enable Google Maps for Android, select "Maps SDK for Android" in the "Additional APIs" section, then select "ENABLE".
  * To enable Google Maps for iOS, select "Maps SDK for iOS" in the "Additional APIs" section, then select "ENABLE".
  * Make sure the APIs you enabled are under the "Enabled APIs" section.

For more details, see [Getting started with Google Maps Platform](https://developers.google.com/maps/gmp-get-started).

### Android

1. Set the `minSdkVersion` in `android/app/build.gradle`:

```groovy
android {
    defaultConfig {
        minSdkVersion 20
    }
}
```

This means that app will only be available for users that run Android SDK 20 or higher.

>2. Make sure you set the `compileSdkVersion` in your "android/app/build.gradle" file to 31:
>
>```
>android {
>  compileSdkVersion 31
>
>  ...
>}
>```

3. Specify your API key in the application manifest `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest ...
  <application ...
    <meta-data android:name="com.google.android.geo.API_KEY"
               android:value="YOUR KEY HERE"/>
```
>
>4. Add the following to your "gradle.properties" file:
>
>```
>android.useAndroidX=true
>android.enableJetifier=true
>```

>5. Make sure you replace all the `android.` dependencies to their AndroidX counterparts (a full list can be found [Android migration guide](https://developer.android.com/jetpack/androidx/migrate)).

#### Hybrid Composition

To use [Hybrid Composition](https://flutter.dev/docs/development/platform-integration/platform-views)
to render the `GoogleMap` widget on Android, set `AndroidGoogleMapsFlutter.useAndroidViewSurface` to
true.

```dart
if (defaultTargetPlatform == TargetPlatform.android) {
  AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
}
```

### iOS

To set up, specify your API key in the application delegate `ios/Runner/AppDelegate.m`:

```objectivec
#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"
@implementation AppDelegate
- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GMSServices provideAPIKey:@"YOUR KEY HERE"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end
```

Or in your swift code, specify your API key in the application delegate `ios/Runner/AppDelegate.swift`:

```swift
import UIKit
import Flutter
import GoogleMaps
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("YOUR KEY HERE")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```
On iOS you'll need to add the following entries to your Info.plist file (located under ios/Runner) in order to access the device's location.

Simply open your Info.plist file and add the following:

``` xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location when open.</string>
<key>NSLocationAlwaysUsageDescription</key>
<string>This app needs access to location when in the background.</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>This app needs access to location when open and in the background.</string>
```

In addition, you need to add the `Background Modes` capability to your XCode project (Project > Signing and Capabilties > "+ Capability" button) and select `Location Updates`.g>This app needs access to location when open and in the background.</string>

Opt-in to the embedded views preview by adding a boolean property to the app's `Info.plist` file
with the key `io.flutter.embedded_views_preview` and the value `YES`.

```xml
<key>io.flutter.embedded_views_preview</key>
<true/>
```

## Usage

### Basic usage

You can use GoogleMapsPickPlace by pushing to a new page using Navigator, OR put as a child of any widget.
When the user picks a place on the map, it will return result to 'getResult' with FullAddress type.

```dart
import 'package:flutter/material.dart';
import 'package:google_maps_pick_place/google_maps_pick_place.dart';

// ...
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GoogleMapsPickPlace(
          apiKey: "YOU GOOGLE MAPS API KEY",
          getResult: (FullAddress result) {
            print('${result.address}');
            /// Don't use Navigator.of(context).pop() it's build in the method
          },
        ),
      ),
    );
```

### Google Maps Pick Place Properties

Parameter | Type | Description
--------- | ---- | -----------
apiKey | String | Google Map Api Token
getResult | Function(FullAddress)? | Method of Getting the address and position
initialPosition | LatLng | Initial position of the map in case there's no location and GPS is off
enableMyLocationButton | bool | Enable or disable the My Location button
apenableSearchButtoniKey | bool | Enable or disable the Search button
loader | Widget | Widget to show while the map is loading
doneButton | Widget? | Widget to show when the map is done loading and apply getResult method
errorButton | Widget? | Widget to show when there's a corruption or there's no internet connection
zoomFactor | double | Zoom factor of the map (default is 5.0)
markerColor | MarkerColor | Marker color of the map (default is red)

### FullAddress Properties

Parameter | Type | Description
--------- | ---- | -----------
address | String? | Formatted address
position | Position? | Position of the address

## License
MIT