//
//  ViewControllerModal.swift
//  navigationCtroller
//
//  Created by huangyuan on 4/6/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

import UIKit

let kSCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let kSCREEN_HEIGHT = UIScreen.mainScreen().bounds.height;


class ViewControllerModal: UIViewController, UINavigationControllerDelegate{
    var titleBTN : UIButton! = UIButton.init(frame: CGRectMake(0, 64, 1, 30))
    var dismisBTN : UIButton! = UIButton.init(type: UIButtonType.System)

    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector:#selector(ViewControllerModal.updateSubViewFrame(_:)), name: kModelUpdateFrame, object: nil)
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.hidden = true;

//        self.navigationController?.view.backgroundColor = UIColor.redColor();
//        self.navigationController?.view!.backgroundColor = UIColor.redColor();
        
//        print(self.navigationController?.);
//UIApplication.sharedApplication().windows.first?.subviews.first?.backgroundColor=UIColor.clearColor();
//
//
//        print(UIApplication.sharedApplication().windows.first?.subviews.first)
//        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if( self.modalPresentationStyle == UIModalPresentationStyle.FullScreen)
        {
//            let alert : UIAlertView = UIAlertView.init(title: nil, message: "PresetingView has been removed", delegate: nil, cancelButtonTitle: nil)
//            alert.show()
//            dispatch_after(3 , dispatch_get_main_queue(), { () -> Void in
//                alert.dismissWithClickedButtonIndex(0, animated: true)
//            })
        }

        dispatch_after(0 , dispatch_get_main_queue(), { () -> Void in
            self.dismisBTN.setTitle("dismissSelf", forState: UIControlState.Normal)
            self.dismisBTN.addTarget(self, action: "dismissSelf", forControlEvents:UIControlEvents.TouchUpInside)
            self.view.addSubview(self.dismisBTN);
            self.dismisBTN.layer.cornerRadius = 5
            self.dismisBTN.backgroundColor = UIColor.grayColor();
            self.dismisBTN.frame = CGRectMake(self.view.frame.width/3, self.view.frame.height/3, self.view.frame.width/3, 39);
            self.dismisBTN.bounds = CGRectMake(0, 0, 1, 39);
            self.dismisBTN.clipsToBounds = true;
            self.dismisBTN.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
            UIView.animateWithDuration(0.3) { () -> Void in
                
                self.dismisBTN.bounds = CGRectMake(0, 0, self.view.frame.width/3, 39);
            }
            
        })


        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews();
        self.view.backgroundColor = UIColor.brownColor()
        self.titleBTN.addTarget(self, action: "dismissSelf", forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(self.titleBTN);
        self.titleBTN.titleLabel?.adjustsFontSizeToFitWidth = true
        self.titleBTN.setTitle(NSStringFromClass(self.classForCoder), forState: UIControlState.Normal)
        
    }
    

    //MARK: - private Method
    
    func dismissSelf() {
        self.dismissViewControllerAnimated(true, completion: nil);
    }
    
    func updateSubViewFrame(objct: NSNotification) {
        let view : UIView = objct.object as! UIView;
        print(view.layer.presentationLayer()?.bounds.width)
        
        self.titleBTN.frame = CGRectMake(10, 64 * 2 / 3, (view.layer.presentationLayer()?.bounds.width)! - 20, 30)
        self.dismisBTN.bounds = CGRectMake(0, 0, view.frame.width/3, 39);

    }
    
    //MARK: - Navigation
    /*

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
