//
//  WSFConstants.h
//  Pods
//
//  Created by wong on 2019/4/9.
//

#ifndef WSFConstants_h
#define WSFConstants_h


#define CurrentViewController [(UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController viewControllers].lastObject

#define EndEditing()  [CurrentViewController.view endEditing:YES]

#define WeakSelfDefined \
__weak typeof(self) weakSelf = self;

#endif /* WSFConstants_h */
