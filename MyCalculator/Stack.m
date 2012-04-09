//
//  Stack.m
//  MyCalculator
//
//  Created by Gary Johnson on 4/7/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import "Stack.h"

@implementation Stack

@synthesize stack = _stack;

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        _stack = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)push:(id)item {

    [_stack insertObject:item atIndex:[_stack count]];
}

-(id)pop {
    
    if (![self isEmpty]) {
        id temp = [self peek];
        [_stack removeObjectAtIndex:[_stack count]-1];
        return temp;
    }
    return NULL;
}

-(void)popall {

    [_stack removeAllObjects];
}

-(NSUInteger)size {
   
    return [_stack count];
}

-(BOOL)isEmpty {
    
    if ([_stack count] != 0) {
        return FALSE;
    }
    
    return TRUE;
}

-(id)peek {
    
    if (![self isEmpty]) {
        return [_stack objectAtIndex:[_stack count]-1];        
    }
    
    return NULL;
}

@end
