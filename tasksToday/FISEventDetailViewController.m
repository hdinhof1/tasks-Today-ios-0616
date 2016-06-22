//
//  FISEventDetailViewController.m
//  tasksToday
//
//  Created by Henry Dinhofer on 6/22/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <EventKit/EventKit.h>
#import "FISEventDetailViewController.h"

@interface FISEventDetailViewController ()



@end

@implementation FISEventDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.accessibilityLabel = @"eventsView";
    self.textViewToDisplayEvents.accessibilityLabel = @"events list";
    self.textViewToDisplayEvents.text = [self titleEventStr];
    //NSLog(@"Did self.events get set up %@", self.eventArray);
//    for (EKEvent *event in self.eventArray) {
//           NSLog(@"title is %@", event.title);
//    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)titleEventStr {
    NSMutableString *text = [[NSMutableString alloc] init];
    for (EKEvent *event in self.eventArray) {
        
        if (self.eventArray.count == 1) {
            [text appendFormat:@"%@", event.title];
        }else {
            [text appendFormat:@"%@\n", event.title];
        }
    }
   // NSLog(@"title str is %@", text);
    return text;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
