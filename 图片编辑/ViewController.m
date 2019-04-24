//
//  ViewController.m
//  图片编辑
//
//  Created by Apple on 2018/10/31.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "ViewController.h"
#import "OneViewController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimage:)];
    [self.imageView addGestureRecognizer:tap];
    
}

- (void)clickimage:(UITapGestureRecognizer *)sender {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    CGPoint point = [sender locationInView:self.imageView];
    view.center = point;
    [self.imageView addSubview:view];
    
    CGFloat px = point.x / CGRectGetWidth(self.imageView.frame);
    CGFloat py = point.y / CGRectGetHeight(self.imageView.frame);
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    view1.backgroundColor = [UIColor redColor];
    view1.center = CGPointMake(150 * px, 150 * py);
    [self.imageView2 addSubview:view1];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    OneViewController * vc = [[OneViewController alloc]init];
    [vc setPointBlock:^(CGFloat x, CGFloat y) {
       
        UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        view1.backgroundColor = [UIColor redColor];
        view1.center = CGPointMake(self.imageView.frame.size.width * x, self.imageView.frame.size.height * y);
        [self.imageView addSubview:view1];
    }];
    [self presentViewController:vc animated:YES completion:nil];
    
}
@end
