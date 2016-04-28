//
//  TabbarController.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/6/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController {

    let vc : ViewController = ViewController.init()
    let vc2 : ViewController2 = ViewController2.init()
    let myDelegate : TabBarTransitionDelegate = TabBarTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViewControllers()
        addGestures()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
//        myDelegate.animate = false
//        selectedIndex = 1
//        myDelegate.animate = true
//        selectedIndex = 0

    }
    
    func geturesHandler(pangesture: UIPanGestureRecognizer){
        let point  = pangesture.translationInView(view).x
        let absolute = point > 0 ? point: -point
        let progress = absolute / view.frame.width
        switch (pangesture.state) {
        case .Began:
            self.myDelegate.animeteFromLeft = false
            myDelegate.interacting = true
            if (pangesture.velocityInView(view).x < 0){
                if( selectedIndex < viewControllers!.count - 1 ){
                    selectedIndex += 1
                }
            }else {
                if(selectedIndex > 0) {
                    selectedIndex -= 1
                }
            }
        case .Changed:
            myDelegate.interactiveTransition.updateInteractiveTransition(progress)
        case .Ended,.Cancelled:
            myDelegate.interacting = false
            self.myDelegate.animeteFromLeft = true

            myDelegate.interactiveTransition.completionSpeed = 0.99
            if(progress > 0.3){
                myDelegate.interactiveTransition.finishInteractiveTransition()
            }else {
                myDelegate.interactiveTransition.cancelInteractiveTransition()
            }

        default: break
        }
    }
    
    
    func addGestures (){
        let gesture : UIPanGestureRecognizer = UIPanGestureRecognizer.init(target: self, action: "geturesHandler:")
        view.addGestureRecognizer(gesture)
    }
    
    func initViewControllers (){
        viewControllers = [vc,vc2]
        vc.tabBarItem = UITabBarItem.init(title: "vc_one", image: UIImage.init(imageLiteral: "我的灰"), tag: 0)
        vc2.tabBarItem = UITabBarItem.init(title:"vc_two", image: UIImage.init(imageLiteral: "找宝贝灰"), tag: 0)
        tabBar.tintColor = UIColor.greenColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName : UIFont.init(name: "Helvetica Neue", size: 15)!], forState: UIControlState.Normal)

        navigationItem.title = "TabBarVC"
        
        self.delegate = myDelegate
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
