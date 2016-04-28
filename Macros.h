//
//  Macros.h
//  navigationCtroller
//
//  Created by huangyuan on 4/4/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#ifndef Macros_h
#define Macros_h

#ifdef __OBJC__


//get the  size of the Screen
#define kSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define kSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width

//适配各种屏幕 设计稿按iPhone6的屏幕来适配
#define kFitH(oHeight) (oHeight)*kSCREEN_HEIGHT/667.0
#define kFitW(oWidth) (oWidth)*kSCREEN_WIDTH/375.0
//适配各种屏幕 设计稿按ios5的屏幕来适配
#define kFitHeight_subs(oHeight) oHeight* ((kSCREEN_HEIGHT/568 -1) / 3 + 1 )
#define kFitHeight(oHeight) oHeight*kSCREEN_HEIGHT/568
#define kFitWidth(oWidth) oWidth*kSCREEN_WIDTH/320

//get the left top origin's x,y of a view
#define kVIEW_X(view) (view.frame.origin.x)
#define kVIEW_Y(view) (view.frame.origin.y)

//get the width size of the view:width,height
#define kVIEW_W(view)  (view.frame.size.width)
#define kVIEW_H(view)  (view.frame.size.height)

//get the right bottom origin's x,y of a view
#define kVIEW_BX(view) (view.frame.origin.x + view.frame.size.width)
#define kVIEW_BY(view) (view.frame.origin.y + view.frame.size.height )

//get the x,y of the frame
#define kFRAME_X(frame)  (frame.origin.x)
#define kFRAME_Y(frame)  (frame.origin.y)
//get the size of the frame
#define kFRAME_W(frame)  (frame.size.width)
#define kFRAME_H(frame)  (frame.size.height)


#endif

#endif /* Macros_h */
