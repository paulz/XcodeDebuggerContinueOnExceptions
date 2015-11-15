//
//  SmartExceptionBreakpoint.h
//  SmartExceptionBreakpoint
//
//  Created by Paul Zabelin on 11/14/15.
//  Copyright © 2015 Paul Zabelin. All rights reserved.
//

@import Foundation;

@interface BinaryUpdater : NSObject
- (BOOL)updateFileAtURL:(NSURL *)fileUrl error:(NSError **)error;
@end
