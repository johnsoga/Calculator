//
//  CalculatorModel.m
//  MyCalculator
//
//  Created by Gary Johnson on 1/17/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import "CalculatorModel.h"

@interface CalculatorModel()
@property (nonatomic, strong) NSMutableArray *stack;
@property (nonatomic, strong) NSMutableArray *queue;
-(int)isNumber:(NSString *)expression atIndex:(NSInteger)index;
-(BOOL)isNegative:(NSString *)token atIndex:(NSInteger)index;
@end


@implementation CalculatorModel
@synthesize stack = _stack;
@synthesize queue = _queue;

-(BOOL)isNegative:(NSString *)token atIndex:(NSInteger)index {
    
    NSRange range = {index-1,1};
    NSString *prev = [token substringWithRange:range];  
    
    if ([token isEqualToString:@"-"]) {
        if (index == 0) {
            return YES;
        } else if(index > 0) {
            if (!([prev isEqualToString:@"0"] || [prev isEqualToString:@"1"] ||
                [prev isEqualToString:@"2"] || [prev isEqualToString:@"3"] ||
                [prev isEqualToString:@"4"] || [prev isEqualToString:@"5"] ||
                [prev isEqualToString:@"6"] || [prev isEqualToString:@"7"] ||
                [prev isEqualToString:@"8"] || [prev isEqualToString:@"9"])) {
                return YES;
            }
        }
    }
    
    return NO;
;}

-(int)isNumber:(NSString *)expression atIndex:(NSInteger)index {
    
    NSString *value = [NSString stringWithFormat:@"%C", [expression characterAtIndex:index]];
    
    if([self isNegative:expression atIndex:index]) {
        index = index + 1;
    }
    
    while ([value isEqualToString:@"0"] || [value isEqualToString:@"1"] ||
           [value isEqualToString:@"2"] || [value isEqualToString:@"3"] ||
           [value isEqualToString:@"4"] || [value isEqualToString:@"5"] ||
           [value isEqualToString:@"6"] || [value isEqualToString:@"7"] ||
           [value isEqualToString:@"8"] || [value isEqualToString:@"9"]) {
        
        return 0;
    }
    
}

-(NSNumber *)evaluate:(NSString *)expression {

    double result = 1337;
    [self shuntingYard:expression];
    
    return [NSNumber numberWithDouble:result];
}

-(void)shuntingYard:(NSString *)expression {
    
    NSInteger length = [expression length];
    int index = 0;
    unichar token;
    
    while (index < length) {
        token = [expression characterAtIndex:length];
        //some code
        
        if ([self isNumber:expression atIndex:index]) {
            break;
        }
        
        continue;
        index++;
        NSLog(@"the Orrrannnnnnge chicken");
    }
    /*
    While there are tokens to be read:
    Read a token.
    If the token is a number, then add it to the output queue.
    If the token is a function token, then push it onto the stack.
    If the token is a function argument separator (e.g., a comma):
    Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue. If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
    If the token is an operator, o1, then:
    while there is an operator token, o2, at the top of the stack, and
        either o1 is left-associative and its precedence is less than or equal to that of o2,
        or o1 is right-associative and its precedence is less than that of o2,
        pop o2 off the stack, onto the output queue;
    push o1 onto the stack.
    If the token is a left parenthesis, then push it onto the stack.
    If the token is a right parenthesis:
    Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue.
    Pop the left parenthesis from the stack, but not onto the output queue.
    If the token at the top of the stack is a function token, pop it onto the output queue.
    If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.
    When there are no more tokens to read:
    While there are still operator tokens in the stack:
    If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
    Pop the operator onto the output queue.
    Exit.
    */
    
    
}


@end
