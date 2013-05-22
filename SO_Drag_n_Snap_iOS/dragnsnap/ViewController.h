//
//  ViewController.h
//  dragnsnap
//
//  Created by Zsolt Normann on 5/20/13.
//  Copyright (c) 2013 Zsolt Normann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIGestureRecognizerDelegate> {
	CGPoint firstPos;
}

@property IBOutlet UIImageView *spot1;
@property IBOutlet UIImageView *spot2;
@property IBOutlet UIImageView *bkgr;
@property IBOutlet UIImageView *dragimg;

- (float) distanceSquared:(CGPoint) p1 p2:(CGPoint) p2;
- (IBAction)pan:(UIPanGestureRecognizer *)gesture;


@end
