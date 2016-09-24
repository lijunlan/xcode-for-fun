//
//  ViewController.m
//  HZKTest
//
//  Created by SDLL18 on 15/3/18.
//  Copyright (c) 2015年 SDLL18. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    float maxp;
    float percsig;
    int nsample;
    NSString *title;
    int ndata;
    float days[100];
    float folds[100];
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.topItem.title  = @"Draw Points";
    [self.navigationController setNavigationBarHidden:NO];
    UIBarButtonItem *btnAddPoint = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStyleBordered target:self action:@selector(addPoint:)];
    UIBarButtonItem *btnClearPoint = [[UIBarButtonItem alloc] initWithTitle:@"Clear" style:UIBarButtonItemStyleBordered target:self action:@selector(clearPoint:)];
    self.navigationController.navigationBar.topItem.rightBarButtonItem = btnAddPoint;
    self.navigationController.navigationBar.topItem.leftBarButtonItem = btnClearPoint;
    
    MyView* myView = (MyView*)self.view;
    [myView setUp];
//  [myView addPoint:[[MyPoint alloc] initWithX:1 withY:2]];
//  [myView addPoint:[[MyPoint alloc] initWithX:5 withY:8]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)clearPoint:(id) sender{
    MyView* myView = (MyView*)self.view;
    [myView clearPoint];
}

- (void)addPoint:(id)sender{
//    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Coordinate" message:@"Please input the coordinate.(eg. 1,1 or 1,1;2,2) " delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
//    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
//    [addPointAlertView show];
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"MaxP" message:@"Please input the data(eg.100.0)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];

}

- (void)setUp2{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Percsig" message:@"Please input the data(eg. 100.0)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)setUp3{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Nsample" message:@"Please input the data(eg.3)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)setUp4{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Title" message:@"Please input the data(eg.Title)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)setUp5{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Ndata" message:@"Please input the data(eg.3)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)setUp6{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Days" message:@"Please input the data(eg.11,12,13)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)setUp7{
    UIAlertView *addPointAlertView = [[UIAlertView alloc] initWithTitle:@"Folds" message:@"Please input the data(eg.15,16,17)" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    addPointAlertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [[addPointAlertView textFieldAtIndex:0] setKeyboardType:UIKeyboardTypeNumberPad];
    [[addPointAlertView textFieldAtIndex:0] becomeFirstResponder];
    [addPointAlertView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration{
    [self.view setNeedsDisplay];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    if([[alertView title] isEqualToString:@"MaxP"]){
//        NSString* input = [alertView textFieldAtIndex:0].text;
//        NSArray* datas = [input componentsSeparatedByString:@";"];
//        float maxp = [[datas objectAtIndex:0] floatValue];
//        float percsig = [[datas objectAtIndex:1] floatValue];
//        int nsample = [[datas objectAtIndex:2] intValue];
//        char* title = (char*)[[datas objectAtIndex:3] UTF8String];
//        int ndata = [[datas objectAtIndex:4] intValue];
//        NSString* strdays = [datas objectAtIndex:5];
//        NSString* strfolds = [datas objectAtIndex:6];
//        NSArray* daysdata = [strdays componentsSeparatedByString:@","];
//        NSArray* foldsdata = [strfolds componentsSeparatedByString:@","];
//        float days[[daysdata count]];
//        float folds[[foldsdata count]];
//        for(int i = 0 ;i<[daysdata count];i++){
//            days[i] = [[daysdata objectAtIndex:i] floatValue];
//            NSLog(@"%f",days[i]);
//        }
//        for(int i = 0 ;i<[foldsdata count];i++){
//            folds[i] = [[foldsdata objectAtIndex:i] floatValue];
//            NSLog(@"%f",folds[i]);
//        }
//        MyView* myView = (MyView*)self.view;
//        [myView setUp:maxp PercSig:percsig Nsample:nsample DataTitle:title nData:ndata days:days folds:folds];
//    }
    if([[alertView title] isEqualToString:@"MaxP"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        maxp = [input floatValue];
        [self setUp2];
    }
    else if([[alertView title] isEqualToString:@"Percsig"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        percsig = [input floatValue];
        [self setUp3];

    }
    else if([[alertView title] isEqualToString:@"Nsample"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        nsample = [input intValue];
        [self setUp4];
    }
    else if([[alertView title] isEqualToString:@"Title"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        title = input;
        [self setUp5];
    }
    else if([[alertView title] isEqualToString:@"Ndata"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        ndata = [input intValue];
        [self setUp6];
    }
    else if([[alertView title] isEqualToString:@"Days"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        NSArray* daysdata = [input componentsSeparatedByString:@","];
        for(int i = 0 ;i<[daysdata count];i++){
            days[i] = [[daysdata objectAtIndex:i] floatValue];
            //NSLog(@"%f",days[i]);
        }
        [self setUp7];
    }
    else if([[alertView title] isEqualToString:@"Folds"]){
        NSString* input = [alertView textFieldAtIndex:0].text;
        NSArray* foldsdata = [input componentsSeparatedByString:@","];
        for(int i = 0 ;i<[foldsdata count];i++){
            folds[i] = [[foldsdata objectAtIndex:i] floatValue];
            //NSLog(@"%f",days[i]);
        }
        MyView* myView = (MyView*)self.view;
        [myView setUp:maxp PercSig:percsig Nsample:nsample DataTitle:[title UTF8String] nData:ndata days:days folds:folds];
    }
//    if ([[alertView title] isEqualToString:@"Coordinate"]) {
//        NSString* input = [alertView textFieldAtIndex:0].text;
//        NSArray* coords = [input componentsSeparatedByString:@";"];
//        for(NSString* c in coords){
//        NSArray* coord = [c componentsSeparatedByString:@","];
//        if([coord count]==2){
//            @try {
//                NSInteger x = [[coord objectAtIndex:0] intValue];
//                NSInteger y = [[coord objectAtIndex:1] intValue];
//                MyView* myView = (MyView*)self.view;
//                [myView addPoint:[[MyPoint alloc] initWithX:x withY:y]];
//            }
//            @catch (NSException *exception) {
//                UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The format of input is not accurate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//                [alert show];
//            }
//            @finally {
//            }
//        }else{
//            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"The format of input is not accurate" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//            [alert show];
//        }
//        }
//    }
    
}

@end
