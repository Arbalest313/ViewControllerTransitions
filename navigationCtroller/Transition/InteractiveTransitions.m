//
//  InteractiveTransitions.m
//  navigationCtroller
//
//  Created by huangyuan on 4/4/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#import "InteractiveTransitions.h"
#import "BaseViewController.h"
@interface InteractiveTransitions ()

@end

@implementation InteractiveTransitions

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    BaseViewController * fromeVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    BaseViewController * toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView * viewcontainer = [transitionContext containerView];
    
    UIView * snapshot = [fromeVC.coverImage snapshotViewAfterScreenUpdates:NO];
    CGRect frame = [viewcontainer convertRect:fromeVC.coverImage.frame fromView:fromeVC.coverImage.superview];

    snapshot.frame = frame;
    
    fromeVC.coverImage.hidden = YES;
    
//    toView.view.frame = [transitionContext finalFrameForViewController:toView];
    toVC.view.alpha = .0f;
    toVC.coverImage.hidden = YES;

    [viewcontainer addSubview:toVC.view];
    [viewcontainer addSubview:snapshot];
    
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        // Fade in the second view controller's view
        toVC.view.alpha = 1.0;
        
        // Move the cell snapshot so it's over the second view controller's image view
        CGRect frame = [viewcontainer convertRect:toVC.coverImage.frame fromView:toVC.coverImage.superview];
        snapshot.frame = frame;
    } completion:^(BOOL finished) {
        // Clean up
        toVC.coverImage.hidden = NO;
        fromeVC.coverImage.hidden = NO;
        [snapshot removeFromSuperview];
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];

}

@end
