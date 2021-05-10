#import "HUDLayer.h"
#import "ActionLayer.h"
#import "AppDelegate.h"
#import "FCGameManager.h"



#import "FCPlayer.h"

@implementation HUDLayer

#pragma mark - 메모리 해제
- (void)dealloc 
{
    [m_pDebugLabel release];
    m_pDebugLabel = nil;
    
    [super dealloc];
}

#pragma mark - 초기화
-(id) init
{
    if( (self=[super init] )) 
    {
        self.isTouchEnabled = YES;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        m_pDebugLabel = [[CCLabelTTF labelWithString:@"" 
                                   dimensions:CGSizeMake(320, 480) alignment:UITextAlignmentCenter 
                                     fontName:@"Arial" fontSize:14.0] retain];
        
        m_pDebugLabel.color = ccRED;
        m_pDebugLabel.position = ccp(winSize.width/2, 
                              winSize.height-(m_pDebugLabel.contentSize.height/2));
        [self addChild:m_pDebugLabel]; 
        
        [self makeJoyStick];
        [self makeButton];
    }
    return self;
}

#pragma mark 버튼 생성
-(void)SetShowJoy:(bool) bShow
{
    //sneaky
    if(bShow == true)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        FCGameManager* pGameManager = [appDelegate GetGameManager];
        int nControlType = [pGameManager GetControlType];
        
        if(nControlType >= 1)
        {
            [leftJoy[nControlType - 1] setVisible:bShow];
            [[leftJoy[nControlType - 1] joystick] setVisible:bShow];
        }
    }
    else 
    {
        [leftJoy[0] setVisible:bShow];
        [[leftJoy[0] joystick] setVisible:bShow];
        
        [leftJoy[1] setVisible:bShow];
        [[leftJoy[1] joystick] setVisible:bShow];
    }
}

-(void)SetShowButton:(bool) bShow
{
    //senaky
    if(bShow == true)
    {
        AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
        FCGameManager* pGameManager = [appDelegate GetGameManager];
        int nControlType = [pGameManager GetControlType];
        
        if(nControlType >= 1)
        {
            [rightButton[nControlType - 1] setVisible:bShow];
            [[rightButton[nControlType - 1] button] setVisible:bShow];
        }
    }
    else {
        [rightButton[0] setVisible:bShow];
        [[rightButton[0] button] setVisible:bShow];
        
        [rightButton[1] setVisible:bShow];
        [[rightButton[1] button] setVisible:bShow];
    }
}

-(void)makeJoyStick
{
    //---------------------------------------------------------------------------------------------
    leftJoy[0] = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    CGPoint point;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        point = ccp(180,130);
    }
    else {
        point = ccp(100,40);
    }
    
    leftJoy[0].position = point;
    CCSprite* pBackgroundSprite = [CCSprite spriteWithFile:@"pad_back.png"];
    CCSprite* pLeftSprite       = [[CCSprite spriteWithFile:@"pad_left.png"] retain];
    CCSprite* pRightSprite      = [[CCSprite spriteWithFile:@"pad_right.png"] retain];
    CCSprite* pCenterSprite     = [[CCSprite spriteWithFile:@"pad_back.png"] retain];
    
    leftJoy[0].backgroundSprite = pBackgroundSprite;
    leftJoy[0].m_pLeftSprite    = pLeftSprite;
    leftJoy[0].m_pRightSprite   = pRightSprite;
    leftJoy[0].m_pCenterSprite  = pCenterSprite;
    
    leftJoy[0].joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
    leftJoy[0].joystick.thumbRadius = 0.0f;
    leftJoy[0].joystick.isDPad = YES;
    leftJoy[0].joystick.numberOfDirections = 8;
    
    
    [self addChild:leftJoy[0]];
    [self SetShowJoy:false];
    //---------------------------------------------------------------------------------------------
    leftJoy[1] = [[[SneakyJoystickSkinnedBase alloc] init] autorelease];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        point = ccp(180,80);
    }
    else {
        point = ccp(100,30);
    }
    
    leftJoy[1].position = point;
    pBackgroundSprite = [CCSprite spriteWithFile:@"pad2_back.png"];
    pLeftSprite       = [[CCSprite spriteWithFile:@"pad2_left.png"] retain];
    pRightSprite      = [[CCSprite spriteWithFile:@"pad2_right.png"] retain];
    pCenterSprite     = [[CCSprite spriteWithFile:@"pad2_back.png"] retain];
        
    leftJoy[1].backgroundSprite = pBackgroundSprite;
    leftJoy[1].m_pLeftSprite    = pLeftSprite;
    leftJoy[1].m_pRightSprite   = pRightSprite;
    leftJoy[1].m_pCenterSprite  = pCenterSprite;
    
    leftJoy[1].joystick = [[SneakyJoystick alloc] initWithRect:CGRectMake(0,0,128,128)];
    leftJoy[1].joystick.thumbRadius = 0.0f;
    leftJoy[1].joystick.isDPad = YES;
    leftJoy[1].joystick.numberOfDirections = 8;
    
    
    [self addChild:leftJoy[1]];
    [self SetShowJoy:false];
    //---------------------------------------------------------------------------------------------
}

-(void)makeButton
{
    //---------------------------------------------------------------------------------------------
    rightButton[0] = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    
    CGPoint point;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //ipad 일 때
        point = ccp(930,130);
    }
    else  {
        //ipad 가 아닐경우
        point = ccp(430,40);        
    }
    
    rightButton[0].position = point;

    CCSprite* pDefault = [CCSprite spriteWithFile:@"button_jump_up.png"];
    CCSprite* pActivated = [CCSprite spriteWithFile:@"button_jump_down.png"];
    CCSprite* pPress = [CCSprite spriteWithFile:@"button_jump_down.png"];
    
    rightButton[0].defaultSprite = pDefault;
    rightButton[0].activatedSprite = pActivated;
    rightButton[0].pressSprite = pPress;
    rightButton[0].button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 128, 128)];

    rightButton[0].button.isHoldable = YES;
    [self addChild:rightButton[0]];
    [self SetShowButton:false];
    //---------------------------------------------------------------------------------------------
    rightButton[1] = [[[SneakyButtonSkinnedBase alloc] init] autorelease];
    
    //point = CGPointMakeBothIPad(410,30);
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        //ipad 일 때
        point = ccp(930,80);
    }
    else 
    {
        //ipad 가 아닐경우
        point = ccp(420,30);    
    }
    
    rightButton[1].position = point;
    
    pDefault = [CCSprite spriteWithFile:@"button2_jump_up.png"];
    pActivated = [CCSprite spriteWithFile:@"button2_jump_down.png"];
    pPress = [CCSprite spriteWithFile:@"button2_jump_down.png"];
    
    rightButton[1].defaultSprite = pDefault;
    rightButton[1].activatedSprite = pActivated;
    rightButton[1].pressSprite = pPress;
    
    rightButton[1].button = [[SneakyButton alloc] initWithRect:CGRectMake(0, 0, 128, 128)];
    rightButton[1].button.isHoldable = YES;
    [self addChild:rightButton[1]];
    [self SetShowButton:false];
    //---------------------------------------------------------------------------------------------
}

#pragma mark 주기적으로 호출되는 함수
-(void)Process:(ccTime)dt
{
#ifdef DEBUG
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    ActionLayer *pActionLayer = (ActionLayer*)([appDelegate GetActionLayer]);
    FCGameMain* pGameMain = [pActionLayer GetGameMain];
    
    if(pActionLayer == NULL)
        return;
    
    if(pGameMain == NULL)
        return;

    FCPlayer* pPlayer = pGameMain->GetLocalPlayer();
    
    if(pPlayer == NULL)
        return;
    
    b2Fixture *pMainFixture = pPlayer->GetMainFixture();

    if(pPlayer) 
    {
        b2Body* pBody = pPlayer->GetBody();
        if(pBody)
        {
            b2Vec2 velocity = pBody->GetLinearVelocity();
            NSString* strPos = [NSString stringWithFormat:@"POS = [%02.2f] [%02.2f] \n",pBody->GetPosition().x,pBody->GetPosition().y];
            NSString* strVelocity   = [NSString stringWithFormat:@"VELOCITY = [%02.2f] [%02.2f] \n",velocity.x,velocity.y];
            NSString* strState      = [NSString stringWithFormat:@"STATE = [%@] \n",pPlayer->GetStateString()];
            NSString* strJump       = [NSString stringWithFormat:@"JUMP = [%d]\n",pPlayer->GetJumpCount()];
            NSString* strFriction   = [NSString stringWithFormat:@"FRICTION = [%f]\n",pMainFixture->GetFriction()];
            NSString* strFrame      = [NSString stringWithFormat:@"FRAME = [%d]\n",pPlayer->GetFrame()];
            
            NSMutableString* strOutput = [[NSMutableString alloc]init];
            [strOutput appendString:strPos];
            [strOutput appendString:strVelocity];
            [strOutput appendString:strState];
            [strOutput appendString:strJump];
            [strOutput appendString:strFriction];
            [strOutput appendString:strFrame];
            [m_pDebugLabel setString:strOutput];
        }
    } 
#endif
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}
- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
