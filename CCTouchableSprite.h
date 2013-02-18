//
//  CCTouchableSprite.h
//  GraviKill
//
//  Created by Nicholas Thompson on 19/11/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCTouchableSprite : CCSprite <CCTouchOneByOneDelegate> {
    void (^blockBegan_)(id sender);
    void (^blockMoved_)(id sender);
    void (^blockEnded_)(id sender);
    
    BOOL active_;
}

@property (nonatomic, readwrite) BOOL active;

-(void) setTouchableTarget:(id)target beganSelector:(SEL)beganSel movedSelector:(SEL)movedSel endedSelector:(SEL)endedSel;


-(void) setTouchableSpriteBeganBlock:(void(^)(id sender))block;
-(void) setTouchableSpriteMovedBlock:(void(^)(id sender))block;
-(void) setTouchableSpriteEndedBlock:(void(^)(id sender))block;



@end
