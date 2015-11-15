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
        
        it(@"should update file url", ^{
            [[binaryUpdater should] beNonNil];
        });
    });

});

SPEC_END
