//
//  viewSpecsSpec.m
//  tasksToday
//
//  Created by Joe Burgess on 6/19/14.
//  Copyright 2014 Joe Burgess. All rights reserved.
//

#import "Specta.h"
#define EXP_SHORTHAND
#import "Expecta.h"
#import "KIF.h"
#import "Swizzlean.h"
#import "FISViewController.h"
#import <EventKit/EventKit.h>


SpecBegin(viewSpecs)

describe(@"viewSpecs", ^{
    __block Swizzlean *swizzler;
    __block Swizzlean *swizzler2;
    
    beforeAll(^{
        swizzler = [[Swizzlean alloc] initWithClassToSwizzle:[FISViewController class]];

        // When getNextYearsEvents is called, just return one event with title "testing"
        [swizzler swizzleInstanceMethod:@selector(getNextYearsEvents) withReplacementImplementation:^(id _self){
            NSLog(@"Boop");
            EKEventStore *story = [[EKEventStore alloc] init];
            EKEvent *event = [EKEvent eventWithEventStore:story];
            event.title = @"testing";

            return @[event];
        }];
        
        swizzler2 = [[Swizzlean alloc] initWithClassToSwizzle:[FISViewController class]];

        // When getLastYearsEvents is called, just return two events
        [swizzler2 swizzleInstanceMethod:@selector(getLastYearsEvents) withReplacementImplementation:^(id _self){
            EKEventStore *store = [[EKEventStore alloc] init];
            EKEvent *event = [EKEvent eventWithEventStore:store];
            event.title = @"testing last year";

            EKEvent *event2 = [EKEvent eventWithEventStore:store];
            event2.title = @"testing last year2";

            return @[event,event2];
        }];
        
        
    });
    

    it(@"Should Display Next Years Events", ^{
        [tester waitForViewWithAccessibilityLabel:@"mainView"];
        [tester tapViewWithAccessibilityLabel:@"next year button"];

        [tester waitForViewWithAccessibilityLabel:@"eventsView"];
        UITextView *textView= (UITextView *)[tester waitForViewWithAccessibilityLabel:@"events list"];
        expect(textView.text).to.equal(@"testing");

    });

    it(@"Should Display last Years Events", ^{
        [tester waitForViewWithAccessibilityLabel:@"mainView"];
        [tester tapViewWithAccessibilityLabel:@"last year button"];

        [tester waitForViewWithAccessibilityLabel:@"eventsView"];
        UITextView *textView= (UITextView *)[tester waitForViewWithAccessibilityLabel:@"events list"];
        expect(textView.text).to.equal(@"testing last year\ntesting last year2\n");

    });
    
    afterEach(^{
        // Press back to reset
        [tester tapViewWithAccessibilityLabel:@"Back"];
    });
    
});

SpecEnd
