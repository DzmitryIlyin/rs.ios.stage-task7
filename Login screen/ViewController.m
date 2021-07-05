//
//  ViewController.m
//  Login screen
//
//  Created by dzmitry ilyin on 7/2/21.
//

#import "ViewController.h"

@interface ViewController () <UITextViewDelegate, UITextFieldDelegate>
@property(nonatomic, strong)UILabel *topLabel;
@property(nonatomic, strong)UITextField *usernameTextField;
@property(nonatomic, strong)UITextField *passwordTextField;
@property(nonatomic, strong)UIButton *authorizeButton;
@property(nonatomic, strong)UIView *pinView;
@property(nonatomic, strong)UILabel *pinLabel;
@property(nonatomic, strong)UIColor *blackCoralColor;
@property(nonatomic, strong)UIColor *littleBoyBlueColor;
@property(nonatomic, strong)UIColor *turquoiseGreenColor;
@property(nonatomic, strong)UIColor *venetianRedColor;
@end


@implementation ViewController

//MARK: UITextFieldDelegate methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.text.length > 0) {
        textField.text = @"";
    }
    textField.layer.borderColor = self.blackCoralColor.CGColor;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

//MARK: hide keyboard on tap anywhere outside UITextField
- (void)hideKeyboardOnTapAround
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard
{
    [self.view endEditing:YES];
}

//MARK: UIButton action handler methods
-(void)buttonHighlight:(id)sender
{
    [((UIButton *)sender).layer setBackgroundColor:[UIColor colorWithRed:108.0/255.0 green:160.0/255.0 blue:220.0/255.0 alpha:0.2].CGColor];
}

-(void)buttonUnhighlight:(id)sender
{
    UIButton *buttonTapped = (UIButton *)sender;
    if ([sender isHighlighted])
    {
        [buttonTapped setBackgroundColor:[UIColor colorWithWhite:1.0 alpha:1.0]];
    }
}

-(void)textFieldHandler:(id)sender
{
    if (![self.usernameTextField.text isEqualToString: @"username"]) {
        self.usernameTextField.layer.borderColor = self.venetianRedColor.CGColor;
    } else {
        self.usernameTextField.layer.borderColor = self.blackCoralColor.CGColor;
    }
    if (![self.passwordTextField.text isEqualToString: @"password"]) {
        self.passwordTextField.layer.borderColor = self.venetianRedColor.CGColor;
    } else {
        self.passwordTextField.layer.borderColor = self.blackCoralColor.CGColor;
    }
    if ([self.usernameTextField.text isEqualToString: @"username"] && [self.passwordTextField.text isEqualToString: @"password"])
    {
        self.turquoiseGreenColor = [UIColor colorWithRed:145.0/255.0 green:199.0/255.0 blue:177.0/255.0 alpha:1.0];
        [self setUIControl:self.usernameTextField enabledState:false andColor:self.turquoiseGreenColor withAplha:0.5];
        [self setUIControl:self.passwordTextField enabledState:false andColor:self.turquoiseGreenColor withAplha:0.5];
        [self setUIControl:self.authorizeButton enabledState:false andColor:self.littleBoyBlueColor withAplha:0.5];
        [self setUpPinUIView];
    }
}

//MARK: UIView helper mehtods
-(void)setUIView:(UIView*)view borderWidth:(float)borderWidth andColor:(UIColor*)color withCornerRadius:(float)cornerRadius
{
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = color.CGColor;
    view.layer.cornerRadius = cornerRadius;
}

//MARK: UIControl helper mehtods
-(void)setUIControl: (UIControl *)control enabledState:(BOOL)state andColor:(UIColor*)color withAplha:(float)alpha
{
    control.enabled = state;
    control.layer.borderColor = color.CGColor;
    control.alpha = alpha;
}

//MARK: UIButton helper mehtods
-(void)setUIButton:(UIButton *)button title:(NSString*)title withSize:(CGFloat)size weight:(UIFontWeight)weight andColor: (UIColor*)color forState:(UIControlState)state
{
    [button setTitle:title  forState:state];
    [button.titleLabel setFont: [UIFont systemFontOfSize:size weight:weight]];
    [button setTitleColor: color forState:state];
}

-(void)setButtonHighlightActions:(UIButton*)button
{
    [button addTarget:self action:@selector(buttonUnhighlight:) forControlEvents:UIControlEventTouchUpInside];
    [button addTarget:self action:@selector(buttonHighlight:) forControlEvents:UIControlEventTouchDown];
}

//MARK: UITextField helper mehtods
- (void)setLeftPaddingUITextField:(UITextField *)field
{
    field.leftView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 10, field.frame.size.height)];
    field.leftViewMode = UITextFieldViewModeAlways;
}

-(void)setUpInitialState
{
    [self setUpHeader];
    [self setUpTextFields];
    [self setUpButton];
}

-(void)refreshInitialState
{
    [self.pinView setHidden:true];
    self.pinView = nil;
    [self setUIControl:self.usernameTextField enabledState:true andColor:self.blackCoralColor withAplha:1.0];
    [self setUIControl:self.passwordTextField enabledState:true andColor:self.blackCoralColor withAplha:1.0];
    [self setUIControl:self.authorizeButton enabledState:true andColor:self.littleBoyBlueColor withAplha:1.0];
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
}

-(CGPoint)calculateCenterFor: (UIView *)current fromAbove:(UIView*)previous withOffset:(float)offset
{
   return CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(previous.frame) + CGRectGetMidY(current.frame) + offset);
}

- (void)setUpHeader
{
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width - 202.0, 36.0)];
    self.topLabel.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.topLabel.frame) +  80.0);
    
    [self.topLabel setText: @"RSSchool"];
    [self.topLabel setFont:[UIFont systemFontOfSize:36.0 weight:UIFontWeightBold]];
    [self.topLabel setTextAlignment:NSTextAlignmentCenter];

    [self.view addSubview:self.topLabel];
}

-(void)setUpTextFields
{
    self.blackCoralColor = [UIColor colorWithRed:76.0/255.0 green:92.0/255.0 blue:104.0/255.0 alpha:1.0];
    self.venetianRedColor = [UIColor colorWithRed:194.0/255.0 green:1.0/255.0 blue:20.0/255.0 alpha:1.0];
    
//    setup username field
    self.usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 303.0, 40.0)];
    self.usernameTextField.center = [self calculateCenterFor:self.usernameTextField fromAbove:self.topLabel withOffset:120.0];
    
    self.usernameTextField.placeholder = @"Login";
    [self.usernameTextField setTextContentType:UITextContentTypeUsername];
    [self setLeftPaddingUITextField:self.usernameTextField];
    [self setUIView:self.usernameTextField borderWidth:1.5f andColor:self.blackCoralColor withCornerRadius:5.0f];
    
//    setup password field
    self.passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(0.0, 0.0, 303.0, 40.0)];
    self.passwordTextField.center = [self calculateCenterFor:self.passwordTextField fromAbove:self.usernameTextField withOffset:30.0];
//    self.passwordTextField.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.usernameTextField.frame) + CGRectGetMidY(self.passwordTextField.bounds) + 30.0);
    
    self.passwordTextField.placeholder = @"Password";
    [self.passwordTextField setTextContentType:UITextContentTypePassword];
    [self.passwordTextField setSecureTextEntry:true];
    [self setLeftPaddingUITextField:self.passwordTextField];
    [self setUIView:self.passwordTextField borderWidth:1.5f andColor:self.blackCoralColor withCornerRadius:5.0f];

    [self.view addSubview:self.usernameTextField];
    [self.view addSubview:self.passwordTextField];
}

-(void)setUpButton
{
    self.littleBoyBlueColor = [UIColor colorWithRed:128.0/255.0 green:164.0/255.0 blue:237.0/255.0 alpha:1.0];
    
//  create rect
    self.authorizeButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 156.0, 42.0)];
    self.authorizeButton.center = [self calculateCenterFor:self.authorizeButton fromAbove:self.passwordTextField withOffset:60.0];
    
//  set button content
    [self setUIButton:self.authorizeButton title:@"Authorize" withSize:20 weight:(UIFontWeight)UIFontWeightSemibold andColor:self.littleBoyBlueColor forState:UIControlStateNormal];
    
//  set button frame style
    [self setUIView:self.authorizeButton borderWidth:2.0f andColor:self.littleBoyBlueColor withCornerRadius:10.0f];
    
//  set button image for its states
    [self.authorizeButton setImage:[UIImage imageNamed:@"person"] forState:UIControlStateNormal];
    [self.authorizeButton setImage:[UIImage imageNamed:@"person_fill"] forState:UIControlStateHighlighted];
    [self.authorizeButton setTitleColor:[UIColor colorWithRed:108.0/255.0 green:160.0/255.0 blue:220.0/255.0 alpha:0.4] forState:UIControlStateHighlighted];
    
//  set button insets and content fill
    [self.authorizeButton setContentEdgeInsets: UIEdgeInsetsMake(12.0, 22.0, 12.0, 22.0)];
    [self.authorizeButton setTitleEdgeInsets: UIEdgeInsetsMake(0.0, 5.0, 0.0, 0.0)];
    [self.authorizeButton setContentVerticalAlignment:UIControlContentVerticalAlignmentFill];
    [self.authorizeButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentFill];
    self.authorizeButton.titleLabel.adjustsFontSizeToFitWidth = true;
    
//  set button actions handling
    [self setButtonHighlightActions:self.authorizeButton];
    [self.authorizeButton addTarget:self action:@selector(textFieldHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.authorizeButton];
}

-(void)setUpPinUIView
{
    self.pinView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 236.0, 110.0)];
    self.pinView.center = [self calculateCenterFor:self.pinView fromAbove:self.authorizeButton withOffset:67.0];
    
    [self setUIView:self.pinView borderWidth:2.0f andColor:UIColor.whiteColor withCornerRadius:10.0f];
    [self setUpPinButtons];
    [self setUpPinLabel];
    
    [self.view addSubview:self.pinView];
}

-(void)setUpPinButtons
{
    float initialXanchor = 23.0;
    for (int i = 1; i<4; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(initialXanchor, 45.0, 50.0, 50.0)];
        initialXanchor += 70;
        
        [self setUIView:button borderWidth:1.5f andColor:self.littleBoyBlueColor withCornerRadius:25.0f];
        
        [self setUIButton:button title:[@(i) stringValue] withSize:24 weight:UIFontWeightSemibold andColor:self.littleBoyBlueColor forState:UIControlStateNormal];
        
        [self setButtonHighlightActions:button];
        [button addTarget:self action:@selector(handlePinEntry:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.pinView addSubview:button];
    }
}

-(void)setUpPinLabel
{
    self.pinLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 20.0)];
    self.pinLabel.center = CGPointMake(CGRectGetMidX(self.pinView.bounds), 25.0);
    [self.pinLabel setTextAlignment:NSTextAlignmentCenter];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"_"];
    [attributedString addAttribute:NSKernAttributeName value:@(6.0f) range:NSMakeRange(0, [attributedString length])];
    [self.pinLabel setFont: [UIFont systemFontOfSize:18 weight:UIFontWeightSemibold]];
    self.pinLabel.attributedText = attributedString;
    
    [self.pinView addSubview:self.pinLabel];
}

-(void)handlePinEntry:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([self.pinLabel.text isEqualToString:@"_"]) {
        self.pinLabel.text = button.titleLabel.text;
    } else if(self.pinLabel.text.length == 2) {
        NSString *tempPinLabelText = [self.pinLabel.text stringByAppendingString:button.titleLabel.text];
        if ([self validatePin:tempPinLabelText]) {
            [self.pinView.layer setBorderColor:self.turquoiseGreenColor.CGColor];
            self.pinLabel.text = tempPinLabelText;
            [self showAlert];
        } else {
            self.pinLabel.text = @"_";
            [self.pinView.layer setBorderColor:self.venetianRedColor.CGColor];
        }
    } else {
        self.pinLabel.text = [self.pinLabel.text stringByAppendingString:button.titleLabel.text];
    }
}

-(BOOL)validatePin: (NSString*)pin
{
    return [pin isEqualToString:@"132"];
}

-(void)showAlert
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Welcome" message:@"You are successfuly authorized" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *refresh = [UIAlertAction actionWithTitle:@"Refresh" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self refreshInitialState];
    }];
    [alert addAction:refresh];
    [alert setModalPresentationStyle:UIModalPresentationPopover];
    [self presentViewController:alert animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:UIColor.whiteColor];
    [self setUpInitialState];
    
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [self hideKeyboardOnTapAround];
        
}

@end


