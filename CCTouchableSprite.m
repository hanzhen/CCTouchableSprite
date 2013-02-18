//
//  CCTouchableSprite.m
//  GraviKill
//
//  Created by Nicholas Thompson on 19/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CCTouchableSprite.h"


@implementation CCTouchableSprite

@synthesize active = active_;


#pragma mark - Block Setters
-(void) setTouchableSpriteBeganBlock:(void(^)(id sender))block { if( block ) { blockBegan_ = [block copy]; } }
-(void) setTouchableSpriteMovedBlock:(void(^)(id sender))block { if( block ) { blockMoved_ = [block copy]; } }
-(void) setTouchableSpriteEndedBlock:(void(^)(id sender))block { if( block ) { blockEnded_ = [block copy]; } }



#pragma mark - Init handlers
-(void) setTouchableTarget:(id)target beganSelector:(SEL)beganSel movedSelector:(SEL)movedSel endedSelector:(SEL)endedSel {
    __block id t = target;
    if (beganSel) { [self setTouchableSpriteBeganBlock:^(id sender) { [t performSelector:beganSel withObject:sender afterDelay:0]; }]; }
    if (movedSel) { [self setTouchableSpriteMovedBlock:^(id sender) { [t performSelector:movedSel withObject:sender afterDelay:0]; }]; }
    if (endedSel) { [self setTouchableSpriteEndedBlock:^(id sender) { [t performSelector:endedSel withObject:sender afterDelay:0]; }]; }
}



#pragma mark - Touch Delegates

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

- (void) onEnterTransitionDidFinish {
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:YES];
}

- (void) onExit {
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

-(void) pauseSchedulerAndActions {
    active_ = NO;
}
-(void) resumeSchedulerAndActions {
    active_ = YES;
}



-(BOOL) isTouchContained:(CGPoint) location {
    return active_ ? CGRectContainsPoint(CGRectMake(0.0f, 0.0f, rect_.size.width, rect_.size.height), location) : NO;
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];

    location = [self convertToNodeSpace:location];
    
    if ([self isTouchContained:location]) {
        if (blockBegan_) blockBegan_(self);
        return YES;
    }
    
	return NO;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
	location = [self convertToNodeSpace:location];
    if ([self isTouchContained:location]) {
        if (blockMoved_) blockMoved_(self);
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (blockEnded_) blockEnded_(self);
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
	[self ccTouchEnded:touch withEvent:event];
}

#endif  
@end
