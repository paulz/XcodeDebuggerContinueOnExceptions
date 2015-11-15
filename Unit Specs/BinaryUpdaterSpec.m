//
//  BinaryUpdaterSpec.m
//  SmartExceptionBreakpoint
//
//  Created by Paul Zabelin on 11/14/15.
//  Copyright 2015 Paul Zabelin. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "BinaryUpdater.h"

SPEC_BEGIN(BinaryUpdaterSpec)

describe(@"BinaryUpdater", ^{
    let(offset, ^id{
        return @(5);
    });
    
    let(data, ^id{
        return [NSData dataWithBytes:"AAA" length:3];
    });
    
    let(binaryUpdater, ^id{
        BinaryUpdater *updater = [BinaryUpdater new];
        updater.atOffset = [offset longLongValue];
        updater.dataToWrite = data;
        return updater;
    });
    
    let(fileUrl, ^id{
        NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
        return [testBundle URLForResource:@"Sample File" withExtension:@"txt"];
    });
    
    context(@"updateFileAtURL:error:", ^{
        it(@"should update file url", ^{
            NSError *error = nil;
            BOOL success = [binaryUpdater updateFileAtURL:fileUrl error:&error];
            [[theValue(success) should] beYes];
            [[error should] beNil];
            
            NSString *contents = [NSString stringWithContentsOfURL:fileUrl
                                                      usedEncoding:nil
                                                             error:nil];
            [[contents should] equal:@"12345AAA90"];
        });
    });
    
    context(@"exception", ^{
        let(invalidHandle, ^id{
            return [[NSFileHandle alloc] initWithFileDescriptor:STDERR_FILENO + 1];
        });
        
        beforeEach(^{
            [[NSFileHandle should] receive:@selector(fileHandleForUpdatingURL:error:)
                                 andReturn:invalidHandle];
            [[invalidHandle should] receive:@selector(closeFile)];
        });
        
        
        it(@"should be reported as error", ^{
            NSError *error = nil;
            BOOL success = [binaryUpdater updateFileAtURL:fileUrl error:&error];
            [[theValue(success) should] beNo];
            [[error should] beNonNil];
            [[error.domain should] equal:@"BinaryUpdaterErrorDomain"];
            [[theValue(error.code) should] equal:theValue(1)];
            
            NSException *illegalSeek = error.userInfo[@"exception"];
            [[illegalSeek.name should] equal:NSFileHandleOperationException];
            [[illegalSeek.reason should] equal:@"*** -[NSConcreteFileHandle seekToFileOffset:]: Illegal seek"];
        });
    });

});

SPEC_END
