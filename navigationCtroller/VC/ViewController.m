//
//  ViewController.m
//  navigationCtroller
//
//  Created by huangyuan on 4/4/16.
//  Copyright © 2016 com.ushopal. All rights reserved.
//

#import "ViewController.h"
#import "ViewController2.h"
#import "InteractiveTransitions.h"
#import "MagnifyViewController.h"
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UINavigationControllerDelegate>
@property (nonatomic, copy)   NSArray * datasource;
@property (nonatomic, strong) UICollectionView * collectionImage;
@property (nonatomic, strong) UISegmentedControl * segment;
@property (nonatomic, strong) ModelTransitionDelegate * modelTransitionDelegate;
@end

@implementation ViewController
{
    UIButton * _popBTN;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
}



- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.navigationItem.title = NSStringFromClass(self.class);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem * button = [[UIBarButtonItem alloc] initWithTitle:@"Modal" style:UIBarButtonItemStyleDone target:self action:@selector(modal)];
    self.navigationItem.rightBarButtonItem = button;
    
    [self collectionImage];
    [self segment];
    [self snapShotNavigationView];
    [self popBTN];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private Method
- (void)magnifyingPush{
    NSLog(@"magnify push");
    MagnifyViewController * vc = [MagnifyViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)modal {
    ViewControllerModal * vc = [ViewControllerModal new];
    UINavigationController * nv = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.transitioningDelegate = self.modelTransitionDelegate;
    nv.transitioningDelegate = self.modelTransitionDelegate;

    if (self.segment.selectedSegmentIndex == 1) {
        vc.modalPresentationStyle = UIModalPresentationCustom;
        nv.modalPresentationStyle = UIModalPresentationCustom;

    }else{
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        nv.modalPresentationStyle = UIModalPresentationFullScreen;

    }
    [self presentViewController:nv animated:YES completion:nil];
}

- (void)didTapSegment:(UISegmentedControl *)segment {

}


#pragma mark - collection Delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datasource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseable" forIndexPath:indexPath];
    UIImageView * imageV;
    if (![cell.contentView viewWithTag:23]) {
        imageV = [UIImageView new];
        imageV.frame = cell.contentView.bounds;
        [cell.contentView addSubview:imageV];
    }else {
        imageV = [cell.contentView viewWithTag:23];
    }
    imageV.tag = 23;
    imageV.image = [UIImage imageNamed:self.datasource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.navigationController) {        
        ViewController2 * vc = [ViewController2 new];
        vc.coverImage.image = [UIImage imageNamed:self.datasource[indexPath.row]];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - getter && setter

- (UICollectionView *)collectionImage {
    if (!_collectionImage) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake((kSCREEN_WIDTH - 20)/2 - 10,(kSCREEN_WIDTH - 20)/2 - 10);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        _collectionImage = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, kSCREEN_WIDTH,kSCREEN_HEIGHT - 64) collectionViewLayout:layout];
        _collectionImage.delegate = self;
        _collectionImage.dataSource = self;
        _collectionImage.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _collectionImage.backgroundColor = [UIColor whiteColor];
        [_collectionImage registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseable"];
        [self.view addSubview:_collectionImage];
    }
    return _collectionImage;
}

- (NSArray *)datasource {
    if (!_datasource) {
        _datasource = @[@"infogather_boy@2x.png",
                        @"infogather_girl@2x.png",
                        @"infogather_girl@2x.png",
                        @"infogather_boy@2x.png",];
    }
    return _datasource;
}

- (UIImageView * )coverImage {
    return [[_collectionImage cellForItemAtIndexPath:[[_collectionImage indexPathsForSelectedItems] firstObject]] viewWithTag:23];
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment = [[UISegmentedControl alloc] initWithItems:@[@"FullScreen",@"Custom"]];
        [_segment addTarget:self action:@selector(didTapSegment:) forControlEvents:UIControlEventValueChanged];
        [_segment sizeToFit];
        [_segment setSelectedSegmentIndex:0];
        self.navigationItem.titleView = _segment;
    }
    return _segment;
}

- (ModelTransitionDelegate *)modelTransitionDelegate {
    if (!_modelTransitionDelegate) {
        _modelTransitionDelegate = [ModelTransitionDelegate new];
    }
    return _modelTransitionDelegate;
}

- (UIView *)snapShotNavigationView{

    return nil;
}


- (UIButton *)popBTN{
    if (!_popBTN) {
        UIButton * customView = [UIButton buttonWithType:UIButtonTypeSystem];
        [customView setBackgroundImage:[UIImage imageNamed:@"infogather_boy"] forState:UIControlStateNormal];
        [customView addTarget:self action:@selector(magnifyingPush) forControlEvents:UIControlEventTouchUpInside];
        customView.frame = CGRectMake(15, 0, 40, 40);
        _popBTN = customView;
        UIBarButtonItem * left = [[UIBarButtonItem alloc] initWithCustomView:customView];
        self.navigationItem.leftBarButtonItem = left;
//        [self.navigationController.navigationBar addSubview:_popBTN];
    }
    return _popBTN;
}

@end
