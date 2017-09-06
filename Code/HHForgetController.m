//
//  HHForgetController.m
//  mj_keyboard
//
//  Created by meiyue on 2017/9/6.
//  Copyright © 2017年 meiyue. All rights reserved.
//

#import "HHForgetController.h"
#import "UIViewController+DismissKeyboard.h"
#import "KeyboardManager.h"
#import "HHMainController.h"

@interface HHForgetController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (weak, nonatomic) IBOutlet UITextField *passTextField;

@property (weak, nonatomic) IBOutlet UITextField *userTextField;


@property (nonatomic,assign)CGFloat offsetY;
@property (nonatomic,assign)CGFloat bottomStance;
@property (nonatomic,assign)CGFloat bottomHeight;



@end

@implementation HHForgetController
{
    CGFloat width;
    CGFloat height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"忘记";
    
    width = [[UIScreen mainScreen]bounds].size.width;
    height = [[UIScreen mainScreen]bounds].size.height;
    
    [self setupForDismissKeyboard];
    
    [self initSubViews];
    
    
    

    [self setup];
    
}

//**************************** 键盘 ********************************/

- (void)setup
{
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillChangeFrame:)
                                                name:UIKeyboardWillChangeFrameNotification
                                              object:nil];
    
    
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    NSDictionary *userInfo = notification.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    void(^animations)() = ^{
        [self _willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:nil];
    
}


- (void)_willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self _willShowBottomHeight:toFrame.size.height];
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        [self _willShowBottomHeight:0];
    }
    else{
        [self _willShowBottomHeight:toFrame.size.height];
    }
}



- (void)_willShowBottomHeight:(CGFloat)bottomHeight
{

    NSArray *array = self.bgView.subviews;
    
    NSMutableArray *textFieldArray = [[NSMutableArray alloc]init];
    
    for (id obj in array) {
        
        if ([obj isKindOfClass:[UITextField class]])
        {
            UITextField *textField = (UITextField *)obj;
            [textFieldArray addObject:textField];
        }
    }
    
    
    for (UITextField *textField in textFieldArray) {
        
        if (textField.isFirstResponder == YES)
        {
            CGFloat h = CGRectGetMaxY(textField.frame) + 100;
            
            CGFloat bottomStance = height - h;
        
            [self setupFrame:bottomStance bottomHeight:bottomHeight];
        }
    }
    
}


// bottomStance 空间的位置距离下面      bottomHeight键盘的高度
- (void)setupFrame:(CGFloat)bottomStance bottomHeight:(CGFloat)bottomHeight
{
    
    self.bottomStance = bottomStance;
    self.bottomHeight = bottomHeight;
    
    [UIView animateWithDuration:0.25 animations:^{
        [self viewDidLayoutSubviews];
    }];

}




- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
    if (self.bottomStance < self.bottomHeight)
    {
        
        CGFloat offetY = self.bottomHeight - self.bottomStance;
        NSLog(@"-------要便宜:(%f)--------",offetY);
        
        [self.bgView layoutIfNeeded];
        
        CGRect rect = self.bgView.frame;
        
        rect.origin.y = - offetY;
        
        self.bgView.frame = rect;
        
    }
    else
    {
        NSLog(@"-------还原--------");

        self.bgView.frame = CGRectMake(0, 0, width, height);
        
        [self.bgView layoutIfNeeded];
    }

}

















- (void)initSubViews
{
    
    
}


- (IBAction)btnAction:(id)sender
{
    
    NSLog(@"-----跳转------");
    NSString *user = self.userTextField.text;
    NSString *pass = self.passTextField.text;
    if ([user isEqualToString:@"Mao"] && [pass isEqualToString:@"123456"]) {
        
        [self.view endEditing:YES];
        
        HHMainController *vc = [[HHMainController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}





@end
