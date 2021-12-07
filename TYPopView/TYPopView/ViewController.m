//
//  ViewController.m
//  TYPopView
//
//  Created by Marvin on 2021/10/26.
//

#import "ViewController.h"
#import "ExamplePopView1.h"
#import "ExamplePopView2.h"
#import "ExamplePopView3.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *titles = @[@"固定高度", @"动态高度", @"动态高度且有最大高度"];
    self.view.backgroundColor = [UIColor whiteColor];
    for (int i = 0; i < titles.count; i ++) {
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width/2. -100, 88 + 60 *i, 200, 40)];
        btn.backgroundColor = [UIColor systemBlueColor];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [btn setTitle:titles[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        if (i == 0) {
            [btn addTarget:self action:@selector(showPopStyle1) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 1) {
            [btn addTarget:self action:@selector(showPopStyle2) forControlEvents:UIControlEventTouchUpInside];
        } else if (i == 2) {
            [btn addTarget:self action:@selector(showPopStyle3) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
}

- (void)showPopStyle1 {
    ExamplePopView1 *popView = [[ExamplePopView1 alloc]init];
    [popView show];
}

- (void)showPopStyle2 {
    ExamplePopView2 *popView = [[ExamplePopView2 alloc]init];
    [popView show];
}

- (void)showPopStyle3 {
    ExamplePopView3 *popView = [[ExamplePopView3 alloc]init];
    [popView show];
}

@end
