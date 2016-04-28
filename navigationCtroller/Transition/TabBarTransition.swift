//
//  TabBarTransition.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/7/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit


enum TabOperationDirection  {
    case Left,Right

}


class TabBarTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var direction : TabOperationDirection = .Left
    init(direction: TabOperationDirection) {
        self.direction = direction
        super.init()
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containView = transitionContext.containerView(), fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey), toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else{
            return
        }
  
        let fromV : UIView! = fromVC.view//transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!.view!
        fromV.tag = 11;
        let toV : UIView! = toVC.view// transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!.view!
        toV.tag = 12;
        let tmp = transitionContext.containerView()
        if tmp == nil {
            return
        }
        
//        let containView : UIView! = tmp
        let transition = containView.frame.width
        var fromTransition = CGAffineTransformIdentity
        var toTransition = CGAffineTransformIdentity

        
        containView.insertSubview(toV, belowSubview: fromV)
        
        switch (direction) {
        case .Left:
            fromTransition = CGAffineTransformMakeTranslation(-transition , 0)
        case .Right:
            fromTransition = CGAffineTransformMakeTranslation(transition , 0)
        }
        toTransition = CGAffineTransformMakeScale(0.9, 0.9);
        toV.transform = toTransition

        UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
            toV.transform = CGAffineTransformIdentity

            fromV.transform = fromTransition
            fromV.alpha = 0.3
            }) { _ in
                fromV.transform = CGAffineTransformIdentity
                toV.transform = CGAffineTransformIdentity
                fromV.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())

        }
        
        
        
    }
}
