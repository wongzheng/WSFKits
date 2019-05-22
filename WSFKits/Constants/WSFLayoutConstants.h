//
//  WSFLayoutConstants.h
//  Pods
//
//  Created by wong on 2019/4/9.
//

#ifndef WSFLayoutConstants_h
#define WSFLayoutConstants_h

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height


#define StandardScreenNum(num)    (ScreenWidth / 375.0f * num)

//iPhoneX / iPhoneXS
#define  isIphoneX_XS     (ScreenWidth == 375.f && ScreenHeight == 812.f ? YES : NO)
//iPhoneXR / iPhoneXSMax
#define  isIphoneXR_XSMax    (ScreenWidth == 414.f && ScreenHeight == 896.f ? YES : NO)
//异性全面屏
#define   isFullScreenDevice    (isIphoneX_XS || isIphoneXR_XSMax)

// Status bar height.
#define  StatusBarHeight     (isFullScreenDevice ? 44.f : 20.f)

// Navigation bar height.
#define  NavigationBarHeight  44.f

// Tabbar height.
#define  TabbarHeight         (isFullScreenDevice ? (49.f+34.f) : 49.f)

// Tabbar safe bottom margin.
#define  TabbarSafeBottomMargin         (isFullScreenDevice ? 34.f : 0.f)

// Status bar & navigation bar height.
#define  StatusBarAndNavigationBarHeight  (isFullScreenDevice ? 88.f : 64.f)



//  http://blog.csdn.net/Scorpio_27/article/details/52297643

#endif /* WSFLayoutConstants_h */
