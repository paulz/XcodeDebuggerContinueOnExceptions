//
//  SmartExceptionBreakpoint.m
//  SmartExceptionBreakpoint
//
//  Created by Paul Zabelin on 11/14/15.
//  Copyright © 2015 Paul Zabelin. All rights reserved.
//

#import "BinaryUpdater.h"

@implementation BinaryUpdater

const long long kDataOffset = 5;

- (NSData *)dataToWrite {
    return [NSData dataWithBytes:"12345" length:5];
}

- (BOOL)updateFileAtURL:(NSURL *)fileUrl error:(NSError **)error {
    NSFileHandle *file = [NSFileHandle fileHandleForUpdatingURL:fileUrl error:error];
    if (!file) {
        return NO;
    }
    @try {
        [file seekToFileOffset:kDataOffset];
        [file writeData:[self dataToWrite]];
    } @catch (NSException *exception) {
        if (error) {
            *error = [NSError errorWithDomain:@"BinaryUpdaterErrorDomain"
                                         code:-1
                                     userInfo:@{@"exception" : exception}];
        }
        return NO;
    } @finally {
        [file closeFile];
    }
    return YES;
}

@end
