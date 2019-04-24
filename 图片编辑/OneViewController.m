//
//  OneViewController.m
//  图片编辑
//
//  Created by Apple on 2018/11/1.
//  Copyright © 2018 Apple. All rights reserved.
//

#import "OneViewController.h"

@interface OneViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic,strong) UIImageView*enlargeImage;
@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.minimumZoomScale = 0.5;
    self.scrollView.maximumZoomScale = 10;
    self.scrollView.contentSize = CGSizeMake(400, 400);
    UIImage *image = [UIImage imageNamed:@"037437AA-7FF1-4C2C-B8DE-258D55B8A124"];
    self.enlargeImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*image.size.height / image.size.width)];
    self.enlargeImage.image = image;
    self.enlargeImage.center = self.scrollView.center;
    
    [self.scrollView addSubview:self.enlargeImage];
    
    self.enlargeImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickimage:)];
    [self.enlargeImage addGestureRecognizer:tap];
    
}

- (void)clickimage:(UITapGestureRecognizer *)sender {
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = [UIColor redColor];
    CGPoint point = [sender locationInView:self.enlargeImage];
    view.center = point;
    [self.enlargeImage addSubview:view];
    
    if (CGRectContainsPoint(self.enlargeImage.frame, point)) {
        NSLog(@"触摸点在视图内");
    }
    CGFloat px,py;
    px=0;py=0;
    if (self.scrollView.zoomScale>1.0) {
        //放大
         px = (point.x*self.scrollView.zoomScale - self.enlargeImage.frame.origin.x) / CGRectGetWidth(self.enlargeImage.frame);
         py = (point.y*self.scrollView.zoomScale - self.enlargeImage.frame.origin.y) / CGRectGetHeight(self.enlargeImage.frame);
    }else{
        //缩小或原图
         px = (point.x*self.scrollView.zoomScale + self.scrollView.contentOffset.x) / CGRectGetWidth(self.enlargeImage.frame);
         py = (point.y*self.scrollView.zoomScale + self.scrollView.contentOffset.y) / CGRectGetHeight(self.enlargeImage.frame);
    }
   
//    NSLog(@"point -----x:%f---y:%f",point.x,point.y);
//    NSLog(@"contentOffset -----x:%f---y:%f",self.scrollView.contentOffset.x,self.scrollView.contentOffset.y);
//    NSLog(@"imageViewFarme --------w:%f---h:%f-----x:%f---y:%f",self.enlargeImage.frame.size.width,self.enlargeImage.frame.size.height,self.enlargeImage.frame.origin.x,self.enlargeImage.frame.origin.y);
    self.PointBlock(px, py);

    [self dismissViewControllerAnimated:NO completion:nil];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"contentOffset -----x:%f---y:%f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    
    return self.enlargeImage;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGRect frame = self.enlargeImage.frame;
    
    frame.origin.y = (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) > 0 ? (self.scrollView.frame.size.height - self.enlargeImage.frame.size.height) * 0.5 : 0;
    frame.origin.x = (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) > 0 ? (self.scrollView.frame.size.width - self.enlargeImage.frame.size.width) * 0.5 : 0;
    self.enlargeImage.frame = frame;
    
    self.scrollView.contentSize = CGSizeMake(self.enlargeImage.frame.size.width + 30, self.enlargeImage.frame.size.height + 30);
}

@end
