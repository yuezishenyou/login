//
//  HHLoginController.m
//  mj_keyboard
//
//  Created by meiyue on 2017/9/6.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "HHLoginController.h"
#import "UIViewController+DismissKeyboard.h"
#import "HHMainController.h"
#import "KeyboardManager.h"


#define kScreenH  ([[UIScreen mainScreen]bounds].size.height)
#define kScreenW  ([[UIScreen mainScreen]bounds].size.width)


@interface HHLoginController ()

@property (nonatomic,strong)UITextField *userTextField;

@property (nonatomic,strong)UITextField *passTextField;

@property (nonatomic,strong)UIView *bgView;


@end

@implementation HHLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"登陆";
    
    [self setupForDismissKeyboard];
    
    [self initSubViews];
    
    
    
    KeyboardManager *manager = [KeyboardManager manager];
    
    manager.bgView = self.bgView;
    
    manager.distance = 100;
    
    [manager start];
    
    

   
    
}


- (void)initSubViews
{
    
    self.bgView = [[UIView alloc]init];
    self.bgView.frame = CGRectMake(0, 0, kScreenW, kScreenH);
    [self.view addSubview:self.bgView];
    
    self.userTextField = [[UITextField alloc]init];
    self.userTextField.frame = CGRectMake((kScreenW - 200) / 2, 400, 200, 40);
    self.userTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.userTextField.placeholder = @"用户名";
    [self.bgView addSubview:self.userTextField];
    
    self.passTextField = [[UITextField alloc]init];
    self.passTextField.frame = CGRectMake((kScreenW - 200) / 2, CGRectGetMaxY(self.userTextField.frame)+ 50, 200, 40);
    self.passTextField.borderStyle = UITextBorderStyleRoundedRect;
    self.passTextField.placeholder = @"密码";
    [self.bgView addSubview:self.passTextField];
    
    
    
    //btn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = CGRectMake((kScreenW - 100) / 2, CGRectGetMaxY(self.passTextField.frame) + 50, 100 , 40);
    
    btn.backgroundColor = [UIColor redColor];
    
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [btn addTarget:self
            action:@selector(btnAction)
  forControlEvents:UIControlEventTouchUpInside];
    
    [self.bgView addSubview:btn];
    
    
}

- (void)btnAction
{
    NSString *user = self.userTextField.text;
    NSString *pass = self.passTextField.text;
    
    if ([user isEqualToString:@"Mao"] && [pass isEqualToString:@"123456"]) {
        
        [self.view endEditing:YES];
        
        HHMainController *vc = [[HHMainController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}




@end


















