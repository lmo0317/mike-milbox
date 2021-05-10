#import "cocos2d.h"
@class SneakyJoystick;

@interface SneakyJoystickSkinnedBase : CCSprite {
	CCSprite *backgroundSprite;
	CCSprite *thumbSprite;
    
    CCSprite *m_pLeftSprite;
    CCSprite *m_pRightSprite;
    CCSprite *m_pCenterSprite;

	SneakyJoystick *joystick;
}

@property (nonatomic, retain) CCSprite *backgroundSprite;

@property (nonatomic, retain) CCSprite *m_pLeftSprite;
@property (nonatomic, retain) CCSprite *m_pRightSprite;
@property (nonatomic, retain) CCSprite *m_pCenterSprite;


@property (nonatomic, retain) CCSprite *thumbSprite;
@property (nonatomic, retain) SneakyJoystick *joystick;

- (void) updatePositions;

@end
