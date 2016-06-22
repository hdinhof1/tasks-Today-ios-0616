//
//  FISViewController.m
//  tasksToday
//
//  Created by Joe Burgess on 6/19/14.
//  Copyright (c) 2014 Joe Burgess. All rights reserved.
//

#import "FISViewController.h"
#import "FISEventDetailViewController.h"
#import <EventKit/EventKit.h>

@interface FISViewController ()


@end

@implementation FISViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self requestCalendarPermission];
   // [self getLastYearsEvents];
    self.accessibilityLabel = @"mainView";

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestCalendarPermission
{
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        
    }];
}

- (NSArray *)getNextYearsEvents
{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = 1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:[NSDate date]
                                                            endDate:oneYearFromNow
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    return events;
}

- (NSArray *)getLastYearsEvents
{
    
    EKEventStore *store = [[EKEventStore alloc] init];
    // Get the appropriate calendar
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Create the start date components
    
    
    // Create the end date components
    NSDateComponents *oneYearFromNowComponents = [[NSDateComponents alloc] init];
    oneYearFromNowComponents.year = -1;
    NSDate *oneYearFromNow = [calendar dateByAddingComponents:oneYearFromNowComponents
                                                       toDate:[NSDate date]
                                                      options:0];
    
    // Create the predicate from the event store's instance method
    NSPredicate *predicate = [store predicateForEventsWithStartDate:oneYearFromNow
                                                            endDate:[NSDate date]
                                                          calendars:nil];
    
    // Fetch all events that match the predicate
    NSArray *events = [store eventsMatchingPredicate:predicate];
    
   
    return events;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FISEventDetailViewController *destinationVC = (FISEventDetailViewController *)segue.destinationViewController;
    if ([segue.identifier isEqualToString:@"nextYear"]) {
        destinationVC.eventArray = [self getNextYearsEvents];
    }
//    if ([((UIButton *)sender).titleLabel.text isEqualToString:@"Last Year"] )  {
    if ([segue.identifier isEqualToString:@"lastYear"] ) {
        destinationVC.eventArray = [self getLastYearsEvents];
    }
}


@end
