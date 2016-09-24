//
//  Regester1Controller.h
//  Will
//
//  Created by SDLL18 on 15/3/9.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register1Controller : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *btnGetNumber;
@property (strong, nonatomic) IBOutlet UIButton *btnQQ;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiXin;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiBo;
- (IBAction)toPassword:(id)sender;
- (IBAction)getNumber:(id)sender;
@end
