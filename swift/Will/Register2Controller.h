//
//  Regester2Controller.h
//  Will
//
//  Created by SDLL18 on 15/3/9.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register2Controller : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtNickName;
@property (strong, nonatomic) IBOutlet UIButton *btnRegester;
@property (strong, nonatomic) IBOutlet UIButton *btnRegetNumber;
@property (strong, nonatomic) IBOutlet UIButton *btnQQ;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiXin;
@property (strong, nonatomic) IBOutlet UIButton *btnWeiBo;
- (IBAction)toNickName:(id)sender;
- (IBAction)doRegister:(id)sender;
@end
