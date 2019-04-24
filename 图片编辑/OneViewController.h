//
//  OneViewController.h
//  图片编辑
//
//  Created by Apple on 2018/11/1.
//  Copyright © 2018 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OneViewController : UIViewController
@property (nonatomic,copy) void (^PointBlock)(CGFloat x ,CGFloat y);
@end

NS_ASSUME_NONNULL_END
