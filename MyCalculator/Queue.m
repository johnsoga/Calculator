//
//  Queue.m
//  MyCalculator
//
//  Created by Gary Johnson on 4/7/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import "Queue.h"

@implementation Queue

@synthesize queue = _queue;

- (id) init {
    
    self = [super init];
    
    if (self) {
        
        _queue = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)enqueue:(id)item {
    
    [_queue insertObject:item atIndex:[_queue count]];
}

-(id)dequeue {
    
    if (![self isEmpty]) {
        id temp = [self peek];
        [_queue removeObjectAtIndex:0];
        return temp;
    }   
    
    return NULL;
}

-(void)dequeueAll {
    
    [_queue removeAllObjects];
}

-(NSUInteger)size {
    
    return [_queue count];
}

-(BOOL)isEmpty {
    
    if ([_queue count] != 0) {
        return FALSE;
    }
    
    return TRUE;
}

-(id)peek {
    
    if (![self isEmpty]) {
        return [_queue objectAtIndex:0];
    }
    
    return NULL;
}

@end
