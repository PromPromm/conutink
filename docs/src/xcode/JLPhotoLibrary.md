# ``JLPhotoLibrary``

Provides methods to requesting [Photo Library](https://developer.apple.com/documentation/photokit/phphotolibrary) permissions

- Since: `3.0.1`

## Overview

It would be required if your app wants to access camera or photo library.
Will trigger only in `install` event. Does not have webview actions yet.

## Topics

### Actions

#### ``$photolibrary.granted()``
Returns `Promise.resolve(Bool)` if the permission is granted.

**Example**

```js
$photolibrary.granted().then(granted => alert(granted));
```

#### ``$photolibrary.authorize(showAlert = false)``

Returns `Promise.resolve(Int)` with the Authorization Status.

If `showAlert = true` then it will prompt an alert requesting the user go _Settings_.

The returned number corresponds to [`PHAuthorizationStatus`](https://developer.apple.com/documentation/photokit/phauthorizationstatus)

- _PHAuthorizationStatusNotDetermined_ = 0
User has not yet made a choice with regards to this application

- _PHAuthorizationStatusRestricted_ = 1

This application is not authorized to access photo data.
The user cannot change this application’s status, possibly due to active restrictions
such as parental controls being in place.

- _PHAuthorizationStatusDenied_ = 2

User has explicitly denied this application access to photos data.

- _PHAuthorizationStatusAuthorized_ = 3

User has authorized this application to access photos data.

- _PHAuthorizationStatusLimited_ = 4

User has authorized this application for limited photo library access. Add _PHPhotoLibraryPreventAutomaticLimitedAccessAlert_ = YES to the application's Info.plist to prevent the automatic alert to update the users limited library selection.

**Example**

```js
$photolibrary.authorize().then(status => $logger.trace(status));
```

### ``info.plist``

Add [NSPhotoLibraryUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nsphotolibraryusagedescription) and [NSCameraUsageDescription](https://developer.apple.com/documentation/bundleresources/information_property_list/nscamerausagedescription) permissions to info.plist

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>If you want to use the photolibrary, you have to give permission.</string>
<key>NSCameraUsageDescription</key>
<string>If you want to use the camera, you have to give permission.</string>
```
