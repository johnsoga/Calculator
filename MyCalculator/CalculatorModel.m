//
//  CalculatorModel.m
//  MyCalculator
//
//  Created by Gary Johnson on 1/17/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import "CalculatorModel.h"
#import "Stack.h"
#import "Queue.h"

@interface CalculatorModel()
@property (nonatomic, strong) Stack *stack;
@property (nonatomic, strong) Queue *queue;
@property (nonatomic, strong) Stack *result;
-(BOOL)isNumber:(NSString *)token;
-(void)shuntingYard:(NSString *)expression;
-(BOOL)isOperator:(NSString *)token;
-(void)doMath:(NSString *)token;
-(NSUInteger)operandPrecedence:(NSString *)operand;
-(BOOL)leftAssociative:(NSString *)operand;
@end


@implementation CalculatorModel
@synthesize stack = _stack;
@synthesize queue = _queue;
@synthesize result = _result;



- (id) init {
    
    self = [super init];
    
    if (self) {
        
        _stack = [[Stack alloc] init];
        _queue = [[Queue alloc] init];
        _result = [[Stack alloc] init];

    }
    
    return self;
}


-(NSUInteger)operandPrecedence:(NSString *)operand {
    
    if ([operand isEqualToString:@"!"]) {
        return 4;
    } else if ([operand isEqualToString:@"*"] || [operand isEqualToString:@"/"] || [operand isEqualToString:@"%"]) {
        return 3;
    } else if ([operand isEqualToString:@"+"] || [operand isEqualToString:@"-"]) {
        return 2;
    } else if ([operand isEqualToString:@"="]) {
        return 1;
    }
    
    return 0;
}


-(BOOL)isNumber:(NSString *)token {
    
    NSNumberFormatter *format = [[NSNumberFormatter alloc] init];
    NSNumber *number;
    
    [format setNumberStyle:NSNumberFormatterDecimalStyle];
    number = [format numberFromString:token];
    
    if (number != nil) {
        return TRUE;
    }
    
    return FALSE;
}


-(BOOL)isOperator:(NSString *)token {
    
    if ([token isEqualToString:@"/"]) {
        return TRUE;
    } else if ([token isEqualToString:@"*"]) {
        return TRUE;
    } else if ([token isEqualToString:@"+"]) {
        return TRUE;
    } else if ([token isEqualToString:@"-"]) {
        return TRUE;
    }
    
    return FALSE;
}


-(void)doMath:(NSString *)token {
    
    if ([token isEqualToString:@"+"]) {
        double op2 = [[_result pop] doubleValue];
        double op1 = [[_result pop] doubleValue];
        [_result push:[NSNumber numberWithDouble:(op1 + op2)]];
    } else if ([token isEqualToString:@"-"]) {
        double op2 = [[_result pop] doubleValue];
        double op1 = [[_result pop] doubleValue];
        [_result push:[NSNumber numberWithDouble:(op1 - op2)]];
    } else if ([token isEqualToString:@"*"]) {
        double op2 = [[_result pop] doubleValue];
        double op1 = [[_result pop] doubleValue];
        [_result push:[NSNumber numberWithDouble:(op1 * op2)]];
    } else if ([token isEqualToString:@"/"]) {
        double op2 = [[_result pop] doubleValue];
        double op1 = [[_result pop] doubleValue];
        [_result push:[NSNumber numberWithDouble:(op1 / op2)]];
    }
}


-(NSNumber *)evaluate:(NSString *)expression {

    id token;
    
    [self shuntingYard:expression];

    while (![_queue isEmpty]) {
        
        token = [_queue dequeue];
        
        if ([token isKindOfClass:[NSNumber class]]) {
            if ([self isNumber:[token stringValue]]) {
                
                [_result push:token];
            }
        } else {
            if ([self isOperator:token]) {
             
                [self doMath:token];
            }
        }
    }
    
    return [_result pop];
}


-(BOOL)leftAssociative:(NSString *)operand {
    
    if ([operand isEqualToString:@"*"] || [operand isEqualToString:@"/"] ||
        [operand isEqualToString:@"+"] || [operand isEqualToString:@"-"] ||
        [operand isEqualToString:@"%"]) {
        
        return TRUE;
    } else if ([operand isEqualToString:@"="] || [operand isEqualToString:@"!"]) {
        
        return FALSE;
    }
    
    return false;
}


-(void)shuntingYard:(NSString *)expression {

    NSUInteger length = [expression length];
    NSInteger index = 0;
    NSString *op1;
    NSString *op2;
    NSString *token;
    NSArray *tokens;


    tokens = [expression componentsSeparatedByString:@"_"];
    length = [tokens count];
    
    while (index < length) {
        
        token = [tokens objectAtIndex:index];
        
        if ([self isNumber:token]) {
            [_queue enqueue:[NSNumber numberWithDouble:[token doubleValue]]];
        } else if ([self isOperator:token]) {
            op1 = token;
            while ([self isOperator:(op2 = [_stack peek])] &&
                   (([self leftAssociative:op1] && ([self operandPrecedence:op1] <= [self operandPrecedence:op2])) ||
                    (![self leftAssociative:op1] && ([self operandPrecedence:op1] < [self operandPrecedence:op2])))) {
            
                       [_queue enqueue:[_stack pop]];
            }
            
            [_stack push:token];
        }
        index++;
    }
                    
    while (![_stack isEmpty]) {
        
        [_queue enqueue:[_stack pop]];
    }        
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
    

@end
