//
//  MagnifyViewController.m
//  navigationCtroller
//
//  Created by huangyuan on 4/19/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#import "MagnifyViewController.h"

@interface MagnifyViewController ()
@property (nonatomic, strong)UIImageView * imageV;

@end

@implementation MagnifyViewController
{
    UIButton * _popBTN;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLayoutSubviews {
    self.view.backgroundColor = [UIColor greenColor];
    [self imageV];
    [self popBTN];
}

#pragma mark - private Method

- (void)popBack{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark -getter && setter
- (UIButton *)popBTN{
    if (!_popBTN) {
        UIButton * customView = [UIButton buttonWithType:UIButtonTypeSystem];
        [customView setBackgroundImage:[UIImage imageNamed:@"infogather_boy"] forState:UIControlStateNormal];
        [customView addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
        customView.frame = CGRectMake(20, 22, 40, 40);
        _popBTN = customView;
        [self.view addSubview:_popBTN];
    }
    return _popBTN;
}

- (UIImageView * )imageV{
    if (!_imageV) {
        _imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"infogather_girl"]];
        _imageV.frame = CGRectMake(kSCREEN_WIDTH/3 , kSCREEN_HEIGHT/3, kSCREEN_WIDTH/3, kSCREEN_WIDTH/3);
        [self.view addSubview:_imageV];
    }
    return _imageV;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
