//
//  BaseViewController.m
//  navigationCtroller
//
//  Created by huangyuan on 4/5/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController () <UINavigationControllerDelegate>
@property (nonatomic, strong)UIPercentDrivenInteractiveTransition * interactivePopTransition;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addGestureToView];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.edgesForExtendedLayout = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - navigationController Delegate
- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if (([toVC isKindOfClass:NSClassFromString(@"MagnifyViewController")])
        || [fromVC isKindOfClass:NSClassFromString(@"MagnifyViewController")]) {
        return [MagnifyPushTransition new];
    }else if (fromVC == self && [toVC isKindOfClass:NSClassFromString(@"BaseViewController")]) {
        return [NSClassFromString(@"InteractiveTransitions") new];
    }
    
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    // Check if this is for our custom transition
    if ([animationController isKindOfClass:NSClassFromString(@"InteractiveTransitions")]||
        [animationController isKindOfClass:[MagnifyPushTransition class]]) {
        return self.interactivePopTransition;
    }
    else {
        return nil;
    }
}



- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer {
    // Calculate how far the user has dragged across the view
    
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // Create a interactive transition and pop the view controller
        if (self.navigationController.viewControllers.count) {
            self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        // Update the interactive transition's progress
//        progress = 0.f;
//        progress += 0.001f;
//        NSLog(@"%f",progress);

        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        // Finish or cancel the interactive transition
        if (progress > 0.35) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
    
}


- (void)addGestureToView{
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
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
