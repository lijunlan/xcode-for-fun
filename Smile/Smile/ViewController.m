//
//  ViewController.m
//  Smile
//
//  Created by SDLL18 on 14-10-12.
//  Copyright (c) 2014年 SDLL18. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

bool isLaugh=false;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)changeFace:(id)sender {
    [_btnChange setTitle:@"123" forState:UIControlStateNormal];
}

@end
