CCTouchableSprite
=================

Extends the Cocos2D CCSprite to be "touchable" and to react to selectors or blocks when being touched.

### Usage

```
  CCTouchableSprite *s = [CCTouchableSprite spriteWithFrameName:@"thingy.png"];
  [s setTouchableTarget:self
          beganSelector:@selector(myTouchBeganSelector:)
          movedSelector:@selector(myTouchMovedSelector:)
          endedSelector:@selector(myTouchEndedSelector:)];

```

```
  CCTouchableSprite *s = [CCTouchableSprite spriteWithFrameName:@"thingy.png"];
  [s setTouchableTarget:self
          beganSelector:@selector(onlyCareAboutTouchBegan:)
          movedSelector:nil
          endedSelector:nil];

```

```
  CCTouchableSprite *s = [CCTouchableSprite spriteWithFrameName:@"thingy.png"];
  [s setTouchableSpriteBeganBlock:^(id sender) {
    // CODE!
  }];
```
