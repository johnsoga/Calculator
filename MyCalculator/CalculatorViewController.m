//
//  CalculatorViewController.m
//  MyCalculator
//
//  Created by Gary Johnson on 1/16/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorModel.h"
#define SCREEN_WIDTH    73

@interface CalculatorViewController ()
@property (nonatomic) BOOL isInEqaution;
@property (nonatomic) BOOL isDecimalNumber;
@property (nonatomic) BOOL isTypingNumber;
@property (nonatomic) BOOL isInParenthesis;
@property (nonatomic) BOOL isAfterParenthesis;
@property (nonatomic) BOOL negativePressed;
@property (nonatomic, strong) CalculatorModel *calculator;
@property (nonatomic, strong) NSString *equation;
@end
    
    
@implementation CalculatorViewController : UIViewController
@synthesize display = _display;
@synthesize isDecimalNumber = _isDecimalNumber;
@synthesize isTypingNumber = _isTypingNumber;
@synthesize isInParenthesis = _isInParenthesis;
@synthesize isAfterParenthesis = _isAfterParenthesis;
@synthesize calculator = _calculator;
@synthesize equation = _equation;
@synthesize isInEqaution = _isInEqaution;
@synthesize negativePressed = _negativePressed;


- (NSString *)equation {
    
    if(!_equation) _equation = [[NSString alloc] init];
    return _equation;
}

- (NSString *)displayAnswer:(NSNumber *)answer {
    
    int length = [[answer stringValue] length] - 1;
    NSString *display = [[NSString alloc] init];
    int i = 0;
    
    display = [display stringByAppendingString:@"\n"];
    for(i = 0; i < SCREEN_WIDTH-length; i++) {
        display = [display stringByAppendingString:@" "];
    }
    display = [display stringByAppendingString:[answer stringValue]];
    return display;
}

- (CalculatorModel *)calculator {
    
    if (!_calculator) _calculator = [[CalculatorModel alloc] init];
    return _calculator;
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if (![self isAfterParenthesis]) {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
        self.equation = [self.equation stringByAppendingString:sender.currentTitle];
        [self setIsTypingNumber:YES];
        [self setIsInEqaution:YES];
    }
}

- (IBAction)decimalPressed:(UIButton *)sender {
    
    if (![self isDecimalNumber]) {
        self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
        self.equation = [self.equation stringByAppendingString:sender.currentTitle];
        [self setIsDecimalNumber:YES];
    }
}

//Used Karnaugh Map to figure out logic here
//turns out to be B + C aka  
//typingNumber + afterParenthesis
- (IBAction)operatorPressed:(UIButton *)sender {
    
    if ([self negativePressed]) {
        self.display.text = [self.display.text stringByAppendingString:@")"];
        [self setNegativePressed:NO];
    }
    if ([self isAfterParenthesis] || [self isTypingNumber]) {
        self.display.text = [self.display.text stringByAppendingFormat:@" %@ ",sender.currentTitle];
        self.equation = [self.equation stringByAppendingFormat:@"%@",sender.currentTitle];
        [self setIsDecimalNumber:NO];
        [self setIsTypingNumber:NO];
        [self setIsAfterParenthesis:NO];
        [self setIsInEqaution:NO];
    }
}

- (IBAction)negativePressed:(UIButton *)sender {
    
    if (![self isTypingNumber]) {
        self.display.text = [self.display.text stringByAppendingString:@"(-"];
        self.equation = [self.equation stringByAppendingString:@"-"];
        [self setIsInEqaution:NO];
        [self setNegativePressed:YES];
    }
}

- (IBAction)leftParenthesisPressed:(UIButton *)sender {
    
    if (![self isTypingNumber] && ![self isAfterParenthesis]) {
        self.display.text = [self.display.text stringByAppendingString:@"("];
        self.equation = [self.equation stringByAppendingString:@"("];
        [self setIsInParenthesis:YES];
        [self setIsInEqaution:NO];
    }
}

- (IBAction)rightParenthesisPressed:(UIButton *)sender {
    
    if ([self negativePressed]) {
        self.display.text = [self.display.text stringByAppendingString:@")"];
        [self setNegativePressed:NO];
    }
    if ([self isInParenthesis] && [self isTypingNumber]) {
        self.display.text = [self.display.text stringByAppendingString:@")"];
        self.equation = [self.equation stringByAppendingString:@")"];
        [self setIsInParenthesis:NO];
        [self setIsDecimalNumber:NO];
        [self setIsTypingNumber:NO]; 
        [self setIsAfterParenthesis:YES];
        [self setIsInEqaution:YES];
    }
}

- (IBAction)enterPressed {
    
    if([self isInEqaution]) {
        NSNumber *result = [[self calculator] evaluate:[self equation]];
        self.display.text = [self.display.text stringByAppendingFormat: @"%@\n", [self displayAnswer:result]];
        [self setEquation:nil];
        [self setIsTypingNumber:NO];
    }
}

@end
