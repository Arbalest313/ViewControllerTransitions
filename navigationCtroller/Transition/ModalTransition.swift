//
//  ModalTransition.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/6/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit
let kModelUpdateFrame = "updateSubViewFrame"
class ModalTransition: NSObject, UIViewControllerAnimatedTransitioning  {

    weak var  animatedView: UIView?
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3;
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromVC : UIViewController! = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let toVC : UIViewController! = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let containView : UIView! = transitionContext.containerView()
        containView.tag = 123;
        toVC.view.center = containView.center
        
        let displayLick : CADisplayLink  = CADisplayLink.init(target: self, selector: "updateSubViewFrame")
        displayLick.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSDefaultRunLoopMode)
        
        if toVC.isBeingPresented(){
            animatedView = toVC.view
            containView.addSubview(toVC.view);
            

            let finalSize = CGSizeMake(kSCREEN_WIDTH * 2 / 3, kSCREEN_HEIGHT * 2 / 3)
            toVC.view.bounds = CGRectMake(0, 0, 1, finalSize.height);
            displayLick.paused = false

            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                toVC.view.bounds = CGRectMake(0, 0,finalSize.width, finalSize.height)
                }, completion: { (finished) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
                    displayLick.paused = true

            })
            
        }else if fromVC.isBeingDismissed() {
            animatedView = fromVC.view
            displayLick.paused = false
            UIView.animateWithDuration(self.transitionDuration(transitionContext), animations: { () -> Void in
                fromVC.view.bounds = CGRectMake(0, 0,0,fromVC.view.bounds.height)
                }, completion: { (finished) -> Void in
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled());
                    displayLick.paused = false
            })

        }
    }
    func updateSubViewFrame() {
        if (animatedView != nil) {
            let view:UIView = animatedView!;
            print(animatedView?.bounds.width)
            NSNotificationCenter.defaultCenter().postNotificationName(kModelUpdateFrame, object:view)
        }
    }
}
