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

//异性全面屏
#define   isFullScreenDevice    ({\
BOOL isiPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
UIWindow *window = [UIApplication sharedApplication].delegate.window;\
if (window.safeAreaInsets.bottom > 0.0) {\
isiPhoneX = YES;\
}\
}\
isiPhoneX;\
})


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
