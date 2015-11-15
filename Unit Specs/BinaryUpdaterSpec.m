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
    context(@"updateFileAtURL:error:", ^{
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
        
        it(@"should update file url", ^{
            [[binaryUpdater should] beNonNil];
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

});

SPEC_END
