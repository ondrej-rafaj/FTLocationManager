//
//  FTLocationManager.h
//
//  Created by Lukas Kukacka on 7/31/13.
//  Copyright (c) 2013 Fuerte Int. All rights reserved.
//
//  Singleton manager for simple block-based asynchronous retrieving of actual users location
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2013 Fuerte Int. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import <Foundation/Foundation.h>

@class CLLocation;

typedef void (^FTLocationManagerCompletionHandler)(CLLocation *location, NSError *error, BOOL locationServicesDisabled);


@interface FTLocationManager : NSObject

/**
 *  Location received from Location services
 */
@property (nonatomic, readonly) CLLocation *location;

/**
 *  Threshold number of location services errors until the error block is called.
 *  When the error is "Location services disabled", this threshold is ignored
 *  Default: 3 (Error block is called on 3rd received error)
 */
@property (nonatomic, assign) NSUInteger maxErrorsCount;

/**
 *  How many seconds should the manager try to obtain location before failing on timeout.
 *  Minimum value is 0.1s. Values lower than 0.1s will be automatically set to 0.1s
 *  Default: 3s
 */
@property (nonatomic, assign) NSTimeInterval errorTimeout;

/**
 *  @return Shared singleton instance
 */
+ (FTLocationManager *)sharedManager;

/**
 *  Asks the manager get current location with the given completion handler block.
 *  Location is updated only once and the location listening is turned off again
 *  to preserve battery.
 *  If you dont provide completion block, STAsset macro will cause app crash because
 *  there is no logical use to update location without using it.
 *
 *  @param completionBlock Comletion block called on when the location is received.
 *      CLLocation * - retrieved CLLocation
 *      NSError * - NSError representing the error returned by CLLocationManager
 *      BOOL locationServicesDisabled - YES if there was any error and it was due to the
 *          location services are disabled for this. This is very often case to be checked
 *          so it is directly passed to the completion handler for a convenience
 */
- (void)updateLocationWithCompletionHandler:(FTLocationManagerCompletionHandler)completion;

@end
