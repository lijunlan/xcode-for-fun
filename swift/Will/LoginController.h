//
//  LoginController.h
//  Will
//
//  Created by SDLL18 on 15/3/7.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnQQ;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiXin;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiBo;
@property (strong, nonatomic) IBOutlet UIButton *btnForget;

- (IBAction)login:(id)sender;
- (IBAction)hideKeyboard:(id)sender;
- (IBAction)toPassword:(id)sender;

@end
