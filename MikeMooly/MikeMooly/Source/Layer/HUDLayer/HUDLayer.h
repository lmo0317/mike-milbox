
#import "CCLayerBase.h"
#import "SneakyJoystick.h"
#import "SneakyJoystickSkinnedJoystickExample.h"
#import "SneakyJoystickSkinnedDPadExample.h"
#import "SneakyButton.h"
#import "SneakyButtonSkinnedBase.h"
#import "ColoredCircleSprite.h"

@interface HUDLayer : CCLayerBase
{
    CCLabelTTF * m_pDebugLabel;  
    
    SneakyJoystickSkinnedBase *leftJoy[2];
    SneakyButtonSkinnedBase *rightButton[2];
}

-(void)makeJoyStick;
-(void)makeButton;
-(void)Process:(ccTime)dt;

-(void)SetShowJoy:(bool) bShow;
-(void)SetShowButton:(bool) bShow;

@end