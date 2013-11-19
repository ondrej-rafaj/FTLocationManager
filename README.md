#FTLocationManager

Utility class for simple block-based getting of current user's location on iOS. This class encapsulates `CLLocationManager` under super-simple, block-based Objective-C interface.

##Usage

### Implement FTLocationManager into your project

1. Download `FTLocationManager` sources from this repository
2. Add files from `FTLocationManager` folder to your project (`FTLocationManager.h`/`.m`)
3. Link you project with `CoreLocation.framework`

### Use it

```objective-c
//  Get FTLocationManager singleton instance
FTLocationManager *locationManager = [FTLocationManager sharedManager];

//  Ask the location manager to get current location and get notified using provided handler block
[locationManager updateLocationWithCompletionHandler:^(CLLocation *location, NSError *error, BOOL locationServicesDisabled) {
    if (error)
    {
        //  Handle error here
        if (locationServicesDisabled) {
            //  Location services are disabled, you can ask the user to enable the for example
        }
    }
    else
    {
        //  Do whatever you want current user's location
    }
}];
```

You are done!

###Additional configuration

You can customize behavior of `FTLocationManager` using some properties, but you do not generally need to to this as it has uses reasonable default values.

####maxErrorsCount
Manager automatically skips few first received error in order to really get some location.

Default value: 3 errors (handler block with error will be fired on 3rd error returned by internal `CLLocationManager`

####errorTimeout
Manager automatically uses timeout to make sure handler block will be really called in some reasonable time from requesting the location.

Default value: 3s (if the internal `CLLocationManager` does not give any location in 3s from calling `updateLocationWithCompletionHandler:`, handler block will be called with custom error with `FTLocationManagerErrorDomain` domain)

##Implementation details

`FTLocationManager` makes use of `CLLocationManager` and encapulates it under very simple block-based interface. Please see example project and source code for details on implementation.


##Compatibility

1. Tested with iOS 5.0+ with ARC

##Contact

FTCoreText is developed by [FuerteInt](http://fuerteint.com). Please [drop us an email](mailto:open-source@fuerteint.com) to let us know you how you are using this component.

##License

Open Source Initiative OSI - The MIT License (MIT):Licensing [OSI Approved License] The MIT License (MIT)

Copyright (c) 2013 Fuerte International

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.