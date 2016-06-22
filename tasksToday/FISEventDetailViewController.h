//
//  FISEventDetailViewController.h
//  tasksToday
//
//  Created by Henry Dinhofer on 6/22/16.
//  Copyright © 2016 Joe Burgess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FISEventDetailViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextView *textViewToDisplayEvents;
@property (strong, nonatomic) NSArray *eventArray;

@end
