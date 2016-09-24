//
//  WelcomeController.m
//  Will
//
//  Created by SDLL18 on 15/3/7.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "WelcomeController.h"
#import "MainTabController.h"


@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    //set navigation bar
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1 ];
    
    NSDictionary* dict = [NSDictionary dictionaryWithObject:[UIFont fontWithName:@"MicrosoftYaHei" size:18] forKey:NSFontAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    //end
    
    //set background
    UIImageView *bgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    
    bgView.frame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y + 20, self.view.bounds.size.width, self.view.bounds.size.height -20);
    
    [self.view addSubview:bgView];
    //end
    
    //check userinfo
    NSUserDefaults* userDefaults = [NSUserDefaults standardUserDefaults];
    if([userDefaults objectIsForcedForKey:@"userInfo"]){
     //TODO
        MainTabController* tabController = [[MainTabController alloc]init];
        [self presentViewController: tabController animated:YES completion:nil];

    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void ) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

@end
