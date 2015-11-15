//
//  SmartExceptionBreakpoint.h
//  SmartExceptionBreakpoint
//
//  Created by Paul Zabelin on 11/14/15.
//  Copyright © 2015 Paul Zabelin. All rights reserved.
//

@import Foundation;

@interface BinaryUpdater : NSObject
@property (nonatomic, strong) NSData *dataToWrite;
@property (nonatomic, assign) long long atOffset;
- (BOOL)updateFileAtURL:(NSURL *)fileUrl error:(NSError **)error;
@end
