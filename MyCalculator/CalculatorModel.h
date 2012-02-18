//
//  CalculatorModel.h
//  MyCalculator
//
//  Created by Gary Johnson on 1/17/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorModel : NSObject

- (NSNumber *)evaluate:(NSString *)expression;
- (void)shuntingYard:(NSString *)expression;


@end
