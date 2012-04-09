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
@property (nonatomic, strong) CalculatorModel *calculator;
@property (nonatomic, strong) NSString *equation;
@property (nonatomic) BOOL isTypingANumber;
@end


@implementation CalculatorViewController : UIViewController
@synthesize display = _display;
@synthesize calculator = _calculator;
@synthesize equation = _equation;
@synthesize isTypingANumber = _isTypingANumber;



/*Deals with properly formatting the equations and answer on the screen
 the equation received by the user should always be left aligned and the
 answer should be on the next line, but right algined. The equation is always
 automatically left aligned, just the answer needs to be right algined since 
 the right alignment is not permanent
 */
- (NSString *)displayAnswer:(NSNumber *)answer {
    
    int length = [[answer stringValue] length];
    NSString *display = [[NSString alloc] init];
    int i = 0;
    display = [display stringByAppendingString:@"\n"];
    
    for(i = 0; i < SCREEN_WIDTH-length; i++) {
        display = [display stringByAppendingString:@" "];
    }
    display = [display stringByAppendingString:[answer stringValue]];
    return display;
}




/*Overrides property getter:
 If no actaul calculator object exists to perform the calculations 
 then the program cannot function make sure that one always exists 
 when called
 */
- (CalculatorModel *)calculator {
    
    if (!_calculator) _calculator = [[CalculatorModel alloc] init];
    return _calculator;
}
- (NSString *)equation {
    
    if (!_equation) _equation = [[NSString alloc] init];
    return _equation;
}



- (IBAction)digitPressed:(UIButton *)sender {
    
    [self setIsTypingANumber:TRUE];
    self.display.text = [self.display.text stringByAppendingString:sender.currentTitle];
    self.equation = [self.equation stringByAppendingString:sender.currentTitle];

}




- (IBAction)operatorPressed:(UIButton *)sender {
    
    [self setIsTypingANumber:FALSE];
    self.display.text = [self.display.text stringByAppendingFormat:@" %@ ",sender.currentTitle];
    self.equation = [self.equation stringByAppendingFormat:@"_%@_",sender.currentTitle];
}




- (IBAction)enterPressed {
    
    
    NSNumber *result = [[self calculator] evaluate:[self equation]];
    self.display.text = [self.display.text stringByAppendingFormat: @"%@\n", [self displayAnswer:result]];
    [self setEquation:nil];

}

@end
