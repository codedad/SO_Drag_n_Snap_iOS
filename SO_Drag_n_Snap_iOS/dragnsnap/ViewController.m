//
//  ViewController.m
//  dragnsnap
//
//  Created by Zsolt Normann on 5/20/13.
//  Copyright (c) 2013 Zsolt Normann. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize dragimg;
@synthesize spot1;
@synthesize spot2;
@synthesize bkgr;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated {
}
 
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float) distanceSquared:(CGPoint) p1 p2:(CGPoint) p2 {
	float dx = (p1.x-p2.x);
	float dy = (p1.y-p2.y);
	return dx*dx+dy*dy;
}

void sort(int*a,int n,int*ndx) {
	int*b,*c,t;
	int*bi,*ci,ti;
	for(b=a+n,bi=ndx+n ; --b>a;) {
		--bi;
		for(c=b,ci=bi;--c>=a;) {
			--ci;
			if(*c>*b)t=*b,*b=*c,*c=t,ti=*bi,*bi=*ci,*ci=ti;
		}
	}
}

- (IBAction)pan:(UIPanGestureRecognizer *)gesture {
	CGPoint translatedPoint = [gesture translationInView:self.view];

	if ([gesture state] == UIGestureRecognizerStateBegan) {
		firstPos = [[gesture view] center];
	}

	translatedPoint = CGPointMake(firstPos.x+translatedPoint.x, firstPos.y+translatedPoint.y);
	[[gesture view] setCenter:translatedPoint];
	
	if ([gesture state] == UIGestureRecognizerStateEnded) {
		CGPoint snapPos;
		int distances[3];
		distances[0] = [self distanceSquared:dragimg.center p2:spot1.center];
		distances[1] = [self distanceSquared:dragimg.center p2:spot2.center];
		distances[2] = [self distanceSquared:dragimg.center p2:bkgr.center];
		int distances_ndx[3] = {0,1,2};
		sort(distances, 3, distances_ndx);
		
		switch (distances_ndx[0]) {
			case 0:
				snapPos = spot1.center;
				break;
			case 1:
				snapPos = spot2.center;
				break;
			default:
				snapPos = bkgr.center;
				break;
		}
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDelegate:self];
		dragimg.center = snapPos;
		[UIView commitAnimations];
	}
}

@end
