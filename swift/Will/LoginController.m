//
//  LoginController.m
//  Will
//
//  Created by SDLL18 on 15/3/7.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "LoginController.h"
#import "URLRequest.h"
#import "StringCheck.h"
#import "MainTabController.h"

@interface LoginController()

@end

@implementation LoginController
@synthesize txtUsername;
@synthesize  txtPassword;
@synthesize btnLogin;
@synthesize btnForget;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)hideKeyboard:(id)sender{
    [txtUsername resignFirstResponder];
    [txtPassword resignFirstResponder];
}

- (IBAction)toPassword:(id)sender {
    [txtPassword becomeFirstResponder];
}

- (IBAction)login:(id)sender {
    //check
    NSString* username = txtUsername.text;
    if(!([StringCheck NSStringIsValidEmail:username]||[StringCheck NSStringIsValidTel:username])){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"不对哦" message:@"一定要输入邮箱或手机号呢" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    //deal
    [btnLogin setEnabled:NO];
    //request
    NSMutableData* postData = [NSMutableData data];
    if([StringCheck NSStringIsValidEmail:username]){
        [postData appendData:[[NSString stringWithFormat:@"email=%@&password=%@",username,txtPassword.text] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    else {
        [postData appendData:[[NSString stringWithFormat:@"phone=%@&password=%@",username,txtPassword.text] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    URLRequest *urlRequest = [[URLRequest alloc]initWithURL:@"http://www.sdll18.com/maven-iwant-web-0.0.1-SNAPSHOT/user/login" withBody:postData];
    [urlRequest startWithCompletion:^(URLRequest *request, NSData *data, BOOL success){
        [btnLogin setEnabled:YES];
        if(success)
        {
            NSError* error = nil;
            NSDictionary *inData = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            if([[inData valueForKey:@"status"] intValue]==0){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:[inData valueForKey:@"msg"] delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
                [alert show];
            }
            //NSDictionary *userInfo = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            //NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            //[userDefaults setObject:userInfo forKey:@"userInfo"];
            //TODO 跳转
            //MainTabController* tabController = [[MainTabController alloc]init];
            //[self presentViewController: tabController animated:YES completion:nil];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错啦" message:@"网络不给力啊" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
            [alert show];
        }
    }];
}
@end
