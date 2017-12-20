//
//  ViewController.m
//  TimerTest
//
//  Created by baidu on 2017/9/3.
//  Copyright © 2017年 gamin. All rights reserved.
//

#import "ViewController.h"
#import "NSTimerViewController.h"
#import "CompareViewController.h"

@interface ViewController ()

// --------------------------
@property (nonatomic,strong) UIButton *nsTimerBtn;
@property (nonatomic,strong) UIButton *gcdTimerBtn;
@property (nonatomic,strong) UIButton *performBtn;
@property (nonatomic,strong) UIButton *commonBtn;
@property (nonatomic,strong) UIStackView *containerView;


@property (nonatomic,strong) dispatch_source_t timer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.containerView];
    [self.containerView addArrangedSubview:self.nsTimerBtn];
    [self.containerView addArrangedSubview:self.performBtn];
    [self.containerView addArrangedSubview:self.gcdTimerBtn];
    
    
    [self configLayout];

    // -------------
  /*  [self.view addSubview:self.scrollView];
    [self.view addSubview:self.button];
    // Do any additional setup after loading the view, typically from a nib.
    // 常规用法
    [self commonUsage];
    
    // 多线程用法
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    [self performInGCD:queue];
    
    
    // 主线程，同一个runloop，添加和取消在不同的mode，是可以取消掉的
    // 其他线程，不同的runloop，添加和取消在不同的runloop，是不能取消的
    [self performSelector:@selector(test6) withObject:nil afterDelay:4];
    NSLog(@"current mode = %@",[[NSRunLoop currentRunLoop] currentMode]);
    [self cancelTimerInNewThread];
    
    
    // GCD timer
    // 可以在任意一个线程或者runloop进行取消操作，不受任何线程和模式等的的影响，推荐使用
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_TIME_NOW, 2*NSEC_PER_SEC), 1, 0);
    dispatch_source_set_event_handler(self.timer, ^{
        [self test9];
    });
    dispatch_resume(self.timer);
 
    */
}
/*
- (void)commonUsage{
    NSLog(@"------开始执行------");
    
    // dispatch_after，它是将block，n秒后，加入到main_queue进行执行，在runloop中进行执行
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,0*NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        NSLog(@"5");
    });
    
    // dispatch，是将下面这段代码，加入到队列中，进行执行
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"4");
    });
    
    
    // NSTimer
    [NSTimer scheduledTimerWithTimeInterval:0 repeats:0 block:^(NSTimer * _Nonnull timer) {
        NSLog(@"7");
    }];
    
    // performSelector
    [self performSelector:@selector(test2)]; // obj_msgSend，不会等待viewDidLoad执行完毕
    [self performSelector:@selector(test3) withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
    
    
    //直接调用
    [self test1];// obj_msgSend，不会等待viewDidLoad执行完毕
    NSLog(@"------结束执行------");
}

- (void)performInGCD:(dispatch_queue_t)queue{
    
    // test6不会执行，因为performSelector运行在runloop中，默认创建一个线程是没有runloop的
    dispatch_async(queue, ^{
        [self performSelector:@selector(test6) withObject:nil afterDelay:3];
    });
}
- (void)cancelTimer{
    NSLog(@"%s,%@",__FUNCTION__,[[NSRunLoop currentRunLoop] currentMode]);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(test6) object:nil];
    
    // test9
    if (self.timer!=nil) {
        dispatch_cancel(self.timer);
    }
}

- (void)cancelTimerInNewThread{
//    [NSThread detachNewThreadWithBlock:^{
//        NSRunLoop *loop = [NSRunLoop currentRunLoop];
//        [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
//        [loop run];
//        [self cancelTimer];
//
//    }];
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(doSomething1:) object:nil];
    // 线程加入线程池等待CPU调度，时间很快，几乎是立刻执行
    [thread1 start];
//    [self performSelector:@selector(cancelTimer) onThread:thread1 withObject:nil waitUntilDone:NO];

}

- (void)test1{
    NSLog(@"1");
}
- (void)test2{
    NSLog(@"2");
}
- (void)test3{
    NSLog(@"3");
}
- (void)test6{
    NSLog(@"%s,%@",__FUNCTION__,[[NSRunLoop currentRunLoop] currentMode]);
    NSLog(@"6");
}
- (void)test9{
    NSLog(@"%s,%@",__FUNCTION__,[NSThread currentThread]);
    NSLog(@"9");
}

- (void)doSomething1:(NSObject *)object {
    // 传递过来的参数
    NSLog(@"doSomething1参数：%@， 线程：%@",object,[NSThread currentThread]);
    NSRunLoop *loop = [NSRunLoop currentRunLoop];
//    [loop addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    NSTimer *timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(cancelTimer) userInfo:nil repeats:NO];
    [loop addTimer:timer forMode:NSDefaultRunLoopMode];
    [loop run];
    NSLog(@"loop = %@",loop);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
   */
#pragma mark - aciton
- (void)buttonClick:(UIButton *)button {
    
    UIViewController *vc;
    if (button == _commonBtn) {
        vc = [[CompareViewController alloc] init];
    }
    else if (button == _nsTimerBtn) {
        vc = [[NSTimerViewController alloc] init];
    }
    else if (button == _performBtn) {
        
    }
    else if (button == _gcdTimerBtn) {
        
    }
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - layout
- (void)configLayout {
    self.containerView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.nsTimerBtn.frame = CGRectMake(0, 0, 100, 40);
    self.performBtn.frame = CGRectMake(0, 0, 100, 40);
    self.gcdTimerBtn.frame = CGRectMake(0, 0, 100, 40);
}

#pragma mark - getters & setters
- (UIButton *)nsTimerBtn {
    if (nil == _nsTimerBtn) {
        _nsTimerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_nsTimerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_nsTimerBtn setTitle:@"NSTimer" forState:UIControlStateNormal];
        [_nsTimerBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nsTimerBtn;
}

- (UIButton *)gcdTimerBtn {
    if (nil == _gcdTimerBtn) {
        _gcdTimerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_gcdTimerBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_gcdTimerBtn setTitle:@"GCDTimer" forState:UIControlStateNormal];
    }
    return _gcdTimerBtn;
}

- (UIButton *)performBtn {
    if (nil == _performBtn) {
        _performBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_performBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_performBtn setTitle:@"performTimer" forState:UIControlStateNormal];
    }
    return _performBtn;
}

- (UIButton *)commonBtn {
    if (nil == _commonBtn) {
        _commonBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commonBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_commonBtn setTitle:@"compare" forState:UIControlStateNormal];
    }
    return _commonBtn;
}

- (UIStackView *)containerView {
    if (nil == _containerView) {
        _containerView = [[UIStackView alloc] init];
        _containerView.axis = UILayoutConstraintAxisVertical;
        _containerView.distribution = UIStackViewDistributionFillEqually;
        _containerView.alignment = UIStackViewAlignmentFill;
        _containerView.spacing = 10;

    }
    return _containerView;
}



@end
