//
//  DetailViewController.h
//  TERT
//
//  Created by SDLL18 on 16/3/15.
//  Copyright (c) 2016年 SDLL18. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

