//
//  MagnifyPushTransition.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/19/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit

class MagnifyPushTransition: NSObject, UIViewControllerAnimatedTransitioning {
    weak var transitionContext: UIViewControllerContextTransitioning?

    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let containView = transitionContext.containerView(), fromVC: BaseViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as? BaseViewController, toVC : BaseViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as? BaseViewController else{
            return
        }
        self.transitionContext = transitionContext
        let toV = toVC.view
        let button = fromVC.popBTN
        containView.addSubview(toV)
        
        
        let btnFrame = containView .convertRect(button.frame, fromView: button.superview)
        let initMagnifyCircle:UIBezierPath = UIBezierPath.init(ovalInRect: btnFrame)
        let x = button.center.x - kSCREEN_WIDTH, y = kSCREEN_HEIGHT - button.center.y
        let radius = sqrt(x * x + y * y)
        let finalMagnifyCircle:UIBezierPath = UIBezierPath.init(ovalInRect: CGRectInset(btnFrame, -radius, -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = finalMagnifyCircle.CGPath
        toV.layer.mask = maskLayer;
        
        let maskAnimation = CABasicAnimation.init(keyPath: "path")
        maskAnimation.fromValue = initMagnifyCircle.CGPath
        maskAnimation.toValue = finalMagnifyCircle.CGPath
        maskAnimation.duration = transitionDuration(transitionContext)
        maskAnimation.delegate = self
        maskLayer.addAnimation(maskAnimation, forKey: "path")
    }

    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {

        transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled())
//        transitionContext?.viewControllerForKey(UITransitionContextToViewControllerKey)?.view.layer.mask = nil
        transitionContext?.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view.layer.mask = nil
        
    }
}
