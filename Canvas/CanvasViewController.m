//
//  CanvasViewController.m
//  Canvas
//
//  Created by Henry Ching on 9/17/15.
//  Copyright © 2015 Henry Ching. All rights reserved.
//

#import "CanvasViewController.h"

@interface CanvasViewController ()
@property (weak, nonatomic) IBOutlet UIView *trayView;
@property CGPoint trayOriginalCenter;
@property float trayUp;
@property float trayDown;
@property (strong, nonatomic) UIImageView *newlyCreatedFace;
@property (strong, nonatomic) IBOutlet UIView *mainView;
@property CGPoint faceOriginalCenter;
@end

@implementation CanvasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.trayUp = self.trayView.center.y + 150;
    self.trayDown = self.trayView.center.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onTrayPanGesture:(UIPanGestureRecognizer *)sender {
    self.trayOriginalCenter = self.trayView.center;

    //CGPoint point = [sender translationInView:sender.view];
    CGPoint velocity = [sender velocityInView:sender.view];
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        //sender.view.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + point.y);
        NSLog(@"Tray Begin");
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        //sender.view.center = CGPointMake(self.trayOriginalCenter.x, self.trayOriginalCenter.y + point.y);
        NSLog(@"Tray Changed");
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        if(velocity.y > 0) {
            sender.view.center = CGPointMake(self.trayOriginalCenter.x, self.trayUp);
        } else {
            sender.view.center = CGPointMake(self.trayOriginalCenter.x, self.trayDown);
        }
        NSLog(@"Tray Ended");
    }
    //[sender setTranslation:CGPointMake(0, 0) inView:sender.view];
}

- (IBAction)onFacePanGesture:(UIPanGestureRecognizer *)sender {
    self.faceOriginalCenter = sender.view.center;
    CGPoint point = [sender translationInView:self.view];
    
    if(sender.state == UIGestureRecognizerStateBegan) {
        NSLog(@"Faces Begin");
        UIImageView *imageView = (UIImageView *)sender.view;
        self.newlyCreatedFace = [[UIImageView alloc] initWithImage:imageView.image];
        [self.mainView addSubview:self.newlyCreatedFace];
        self.newlyCreatedFace.center = CGPointMake(imageView.center.x, imageView.center.y + self.trayView.frame.origin.y);
    } else if(sender.state == UIGestureRecognizerStateChanged) {
        NSLog(@"Faces Changed");
        self.newlyCreatedFace.center = CGPointMake(self.faceOriginalCenter.x + point.x, self.faceOriginalCenter.y + point.y + self.trayView.frame.origin.y);
    } else if(sender.state == UIGestureRecognizerStateEnded) {
        NSLog(@"Faces Ended");
    }
}
@end
