//
//  Queue.h
//  MyCalculator
//
//  Created by Gary Johnson on 4/7/12.
//  Copyright (c) 2012 Apple Inc. Retail. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject

@property (strong, nonatomic) NSMutableArray *queue;

-(void)enqueue:(id)item;
-(id)dequeue;
-(void)dequeueAll;
-(NSUInteger)size;
-(BOOL)isEmpty;
-(id)peek;

@end
