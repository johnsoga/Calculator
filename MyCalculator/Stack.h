//
//  Stack.h
//  MyCalculator
//
//  Created by Gary Johnson on 4/7/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
    
@property (strong, nonatomic) NSMutableArray *stack;

-(void)push:(id)item;
-(id)pop;
-(void)popall;
-(NSUInteger)size;
-(BOOL)isEmpty;
-(id)peek;

@end
