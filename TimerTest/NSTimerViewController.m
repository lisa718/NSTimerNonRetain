//
//  NSTimerViewController.m
//  TimerTest
//
//  Created by baidu on 2017/10/16.
//  Copyright © 2017年 gamin. All rights reserved.
//

#import "NSTimerViewController.h"

@interface NSTimerViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UILabel *timerCountLabel;
@property (nonatomic,strong) UIButton *closeButton;


@end

@implementation NSTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.timerCountLabel];
    [self.view addSubview:self.closeButton];
    
    [self configLayout];
    
    [self setTimerInDefaultMode];
//    [self setTimerInCommonMode];
    
    // NSTimer引起环的问题
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    NSLog(@"%s",__FUNCTION__);
}
// 会不影响trackingMode，滚动不执行
// 场景：倒计时
- (void)setTimerInDefaultMode {
    
    __block int i = 0;
    __weak typeof(self) weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        i++;
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.timerCountLabel setText:[@(i%60) stringValue]];
        NSLog(@"current runloop = %p",[NSRunLoop currentRunLoop]);
    }];
}

// 影响trackingmode，可以在这两个mode同时执行
- (void)setTimerInCommonMode {
    
    __block int i = 0;
    __weak typeof(self) weakSelf = self;
    
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        i++;
        __strong typeof(self) strongSelf = weakSelf;
        [strongSelf.timerCountLabel setText:[@(i%60) stringValue]];
        NSLog(@"current runloop = %p",[NSRunLoop currentRunLoop]);

//        [timer invalidate];
    }];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)scrollViewDidScroll:(UIScrollView*)scrollView{
    NSLog(@"current runloop scrolling= %p",[NSRunLoop currentRunLoop]);

}

#pragma mark - layout
- (void)configLayout {
    
//    self.containerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.timerCountLabel.frame = CGRectMake(100, 50, 100, 40);
    self.scrollView.frame = CGRectMake(0, 100, self.view.bounds.size.width, 400);
    self.closeButton.frame = CGRectMake(100, 550, 100, 40);
    
//    [self.containerView addArrangedSubview:self.timerCountLabel];
//    [self.containerView addArrangedSubview:self.scrollView];
}

- (void)close {
    if (self.navigationController == nil) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - getter & setter

- (UIScrollView*)scrollView{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        _scrollView.backgroundColor = [UIColor grayColor];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, 3000);
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UILabel *)timerCountLabel {
    if (_timerCountLabel == nil) {
        _timerCountLabel = [[UILabel alloc] init];
        [_timerCountLabel setTextColor:[UIColor redColor]];
        [_timerCountLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _timerCountLabel;
}

- (UIButton *)closeButton {
    if (nil == _closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_closeButton setTitle:@"close" forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

@end
