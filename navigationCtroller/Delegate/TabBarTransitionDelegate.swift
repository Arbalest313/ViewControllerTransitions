//
//  TabBarTransitionDelegate.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/7/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit

class TabBarTransitionDelegate: NSObject, UITabBarControllerDelegate  {

    var interactiveTransition = UIPercentDrivenInteractiveTransition()
    var animeteFromLeft : Bool = true;
    var interacting : Bool = false
    var animate : Bool = true;
    func tabBarController(tabBarController: UITabBarController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interacting ? interactiveTransition : nil
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        var direction : TabOperationDirection = tabBarController.viewControllers!.indexOf(fromVC)! < tabBarController.viewControllers!.indexOf(toVC)! ? .Left : .Right
        if animeteFromLeft {
            direction = .Right;
        }
        if animate{
            return TabBarTransition(direction: direction)
        }else {
            return nil
        }
        
        
    }
}
