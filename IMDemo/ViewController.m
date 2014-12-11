//
//  ViewController.m
//  IMDemo
//
//  Created by WhoJun on 14/12/11.
//  Copyright (c) 2014年 WhoJun. All rights reserved.
//

#import "ViewController.h"
#import "IM.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (strong, nonatomic)NSMutableArray *chatList;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatBarConstraintBottom;
@property (weak, nonatomic) IBOutlet UIView *chatBar;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;

@end

@implementation ViewController

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.chatList = [NSMutableArray array];
    NSString *msg = @"你妹";
    
    for(int i = 0; i < 20; i++) {
        int type = arc4random_uniform(2);//判断是谁
        msg = [msg stringByAppendingFormat:@"呵呵呵呵[草泥马]"];
        [self.chatList addObject:[[WJChatFrame alloc]initWithMsg:@{@"type":@(type),@"msg":msg}]];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //键盘通知
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(keyboardWillChangeNotice:)
                                                name:UIKeyboardWillChangeFrameNotification
                                              object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillChangeFrameNotification
                                                 object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - recognizer
- (IBAction)tapRecognizer:(id)sender {
    [_textField resignFirstResponder];
}

#pragma mark Recognizer delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if (gestureRecognizer == self.tapRecognizer && ([touch.view isKindOfClass:[UIControl class]]))
    {
        return NO;
    }
    
    return YES;
}

#pragma mark - key board
- (void)keyboardWillChangeNotice:(NSNotification *)notice {
    NSDictionary *userInfo = notice.userInfo;
    CGRect endFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect beginFrame = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    [self willShowKeyboardFromFrame:beginFrame toFrame:endFrame];
    void(^animations)() = ^{
        [self.chatBar.superview layoutIfNeeded];
    };
    
    void(^completion)(BOOL) = ^(BOOL finished){
    };
    
    [UIView animateWithDuration:duration delay:0.0f options:(curve << 16 | UIViewAnimationOptionBeginFromCurrentState) animations:animations completion:completion];
}

#pragma mark animation
- (void)willShowKeyboardFromFrame:(CGRect)beginFrame toFrame:(CGRect)toFrame
{
    if (beginFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        self.chatBarConstraintBottom.constant = toFrame.size.height;
    }
    else if (toFrame.origin.y == [[UIScreen mainScreen] bounds].size.height)
    {
        self.chatBarConstraintBottom.constant = 0;
    }
    else{
        self.chatBarConstraintBottom.constant = toFrame.size.height;
    }
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJChatFrame *chatFrame = self.chatList[indexPath.row];
    WJChatCell *cell = [tableView dequeueReusableCellWithIdentifier:chatFrame.identifier forIndexPath:indexPath];
    [cell setChatFrame:chatFrame];
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJChatFrame *chatFrame = self.chatList[indexPath.row];
    return [chatFrame.frameParams[@"cellHeight"] doubleValue];
}
@end
