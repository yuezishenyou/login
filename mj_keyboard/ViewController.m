//
//  ViewController.m
//  mj_keyboard
//
//  Created by meiyue on 2017/9/6.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "ViewController.h"
#import "HHLoginController.h"
#import "HHForgetController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"vc";
    
    [self initSubViews];
    
}


- (void)initSubViews
{
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc]initWithTitle:@"登陆" style:UIBarButtonItemStylePlain target:self action:@selector(loginPush)];
    
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc]initWithTitle:@"忘记" style:UIBarButtonItemStylePlain target:self action:@selector(forgetPush)];
    
    self.navigationItem.rightBarButtonItem = item1;
    
    self.navigationItem.leftBarButtonItem = item2;
    
    
}


- (void)loginPush
{
    
    HHLoginController *vc = [[HHLoginController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)forgetPush
{
    
    HHForgetController *vc = [[HHForgetController alloc]init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}











@end
