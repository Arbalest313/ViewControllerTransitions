//
//  ModelTransitionDelegate.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/6/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit

class ModelTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ModalTransition()
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ModalTransition()
    }
    
    
}
