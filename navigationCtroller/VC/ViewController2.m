//
//  VC_2.m
//  navigationCtroller
//
//  Created by huangyuan on 4/4/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#import "ViewController2.h"
#import "InteractiveTransitions.h"
#import "navigationCtroller-Swift.h"
@interface ViewController2 () <UINavigationControllerDelegate>
@end

@implementation ViewController2
{
    UIImageView * _coverImage;
}
@dynamic coverImage;

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
        self.navigationController.delegate = self;
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;

}

- (void)viewdidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    // Stop being the navigation controller's delegate
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.navigationItem.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor grayColor];

    [self coverImage];

}

#pragma mark - private Method



- (void)pushToTabBarVC{
    TabbarController * tb = [TabbarController new];

    [self.navigationController pushViewController:tb animated:YES];
}



#pragma mark - getter && setter

- (UIImageView *)coverImage {
    if (!_coverImage) {
        _coverImage = [[UIImageView alloc] init];
        _coverImage.frame = CGRectMake(kSCREEN_WIDTH * 1/8, kSCREEN_HEIGHT * 2/8, kSCREEN_WIDTH* 6/8, kSCREEN_WIDTH * 6/8);
        _coverImage.image = [UIImage imageNamed:@"infogather_boy"];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToTabBarVC)];
        [_coverImage addGestureRecognizer:tap];
        _coverImage.userInteractionEnabled = YES;
        [self.view addSubview:_coverImage];
    }
    return _coverImage;
}
@end

